import { BadRequestException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateVolunteerTeamDto } from './dto/create-volunteer-team.dto';
import { UpdateVolunteerTeamDto } from './dto/update-volunteer-team.dto';

@Injectable()
export class VolunteerTeamService {
  constructor(private readonly prisma: PrismaService) {}

  async getVolunteerTeam(vtId: number) {
    return await this.prisma.volunteerTeam.findUnique({
      where: { id: vtId },
    });
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

  // Be careful with unique constraints
  async connectVolunteerTeamToHelpCenter(vtId: number, hcId: number) {
    return await this.prisma.volunteerTeam.update({
      where: { id: vtId },
      data: {
        helpCenter: {
          connect: {
            id: vtId,
          },
        },
        helpCenterId: hcId,
      },
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
