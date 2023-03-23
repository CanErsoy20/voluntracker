import { BadRequestException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateVolunteerTeamDto } from './dto/create-volunteer-team.dto';
import { UpdateVolunteerTeamDto } from './dto/update-volunteer-team.dto';

@Injectable()
export class VolunteerTeamService {
  constructor(private readonly prisma: PrismaService) {}

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
}
