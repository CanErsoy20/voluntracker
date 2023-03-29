import { BadRequestException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { UserRolesService } from 'src/authorization/user-roles.service';
import { NotRelatedToHelpCenterException } from 'src/exceptions/not-related-to-help-center-exception.exception';
import { NotRelatedToTeamException } from 'src/exceptions/not-related-to-team.exception';
import { UniqueEntityAlreadyExistsException } from 'src/exceptions/unique-entity-already-exists-exception.exception';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateVolunteerLeaderDto } from './dto/create-volunteer-leader.dto';
import { CreateVolunteerTeamDto } from './dto/create-volunteer-team.dto';
import { UpdateVolunteerTeamDto } from './dto/update-volunteer-team.dto';
import { VolunteerService } from './volunteer.service';

// TODO: MODIFY REQUESTS CAN ONLY BE DONE BY ADMINS OR COORDINATORS OF THE HELP CENTER OR THE TEAM LEADER OF THE SPECIFIC TEAM THAT IS BEING MODIFIED

@Injectable()
export class VolunteerTeamService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly volunteerService: VolunteerService,
    private readonly userRoleService: UserRolesService,
  ) {}

  async getVolunteerTeam(vtId: number) {
    const volunteerTeam = await this.prisma.volunteerTeam.findUnique({
      where: { id: vtId },
    });

    if (!volunteerTeam) {
      throw new UniqueEntityNotFoundException('Volunteer team with given ID cannot be found.');
    }

    return volunteerTeam;
  }

  async createVolunteerTeam(createVolunteerTeamDto: CreateVolunteerTeamDto) {
    try {
      const vt = await this.prisma.volunteerTeam.create({
        data: createVolunteerTeamDto,
      });
      return vt;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException(
            'The specified volunteer team already exists in the given help center',
          );
        }
      }
    }
  }

  async deleteVolunteerTeam(vtId: number) {
    return await this.prisma.volunteerTeam.delete({
      where: { id: vtId },
    });
  }

  async updateVolunteerTeam(vtId: number, updateVolunteerTeamDto: UpdateVolunteerTeamDto) {
    return await this.prisma.volunteerTeam.update({
      where: { id: vtId },
      data: updateVolunteerTeamDto,
    });
  }

  async getUnassignedVolunteerTeams() {
    return await this.prisma.volunteerTeam.findMany({
      where: {
        OR: [{ helpCenterId: null }, { helpCenter: null }],
      },
    });
  }

  async assignVolunteerAsLeaderToTeam(
    volunteerTeamId: number,
    volunteerId: number,
    createVolunteerLeaderDto: CreateVolunteerLeaderDto,
  ) {
    const volunteerTeam = await this.prisma.volunteerTeam.findUnique({
      where: {
        id: volunteerTeamId,
      },
      include: {
        teamLeader: true,
        helpCenter: true,
      },
    });
    if (!volunteerTeam) {
      throw new UniqueEntityNotFoundException(
        'The volunteer team you are trying to assign a leader to does not exist',
      );
    }
    if (volunteerTeam.teamLeader) {
      throw new UniqueEntityAlreadyExistsException(
        'The team already has a team leader. Unassign the team leader before trying to assign a new leader.',
      );
    }
    if (!volunteerTeam.helpCenter) {
      throw new NotRelatedToHelpCenterException(
        'No help center contains the team you are trying to assign a leader to.',
      );
    }

    // Volunteer and the team are not assigned to the same help center
    const volunteer = await this.volunteerService.getVolunteer(volunteerId);
    if (!volunteer.helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        `The volunteer is not assigned to any help center. Each volunteer must be assigned to a help center
         before being assigned to any team.`,
      );
    }
    if (volunteer.helpCenterId !== volunteerTeam.helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        `The volunteer is not at the same help center with the team that it is being assigned to.`,
      );
    }
    if (volunteer.volunteerTeamId !== volunteerTeam.id) {
      throw new NotRelatedToTeamException(
        `The volunteers must already be in the team in order to be assigned as a team leader to that team.`,
      );
    }

    const team = await this.prisma.volunteerTeam.update({
      where: {
        id: volunteerTeam.id,
      },
      data: {
        teamLeader: {
          create: createVolunteerLeaderDto,
        },
      },
      include: {
        teamLeader: true,
      },
    });
    const userRole = await this.userRoleService.addUserRoleByVolunteerId(volunteerId, 'VolunteerTeamLeader');
    return userRole;
  }
}
