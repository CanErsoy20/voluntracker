import { Injectable } from '@nestjs/common';
import { UserNotFoundException } from 'src/exceptions/user-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class VolunteerService {
  constructor(private readonly prisma: PrismaService) {}

  async getVolunteer(volunteerId: number) {
    const volunteer = await this.prisma.volunteer.findUnique({
      where: { id: volunteerId },
      include: {
        helpCenter: true,
        helpCenterCoordinator: true,
        user: true,
        volunteerTeam: true,
        volunteerTeamLeader: true,
        volunteerType: true,
      },
    });

    if (!volunteer) {
      throw new UserNotFoundException('Volunteer with given ID cannot be found.');
    }

    return volunteer;
  }

  async getVolunteerByUserId(userId: number) {
    const user = await this.prisma.volunteer.findUnique({
      where: { userId },
    });

    if (!user) {
      throw new UserNotFoundException('User with given ID cannot be found.');
    }

    return user;
  }

  async deleteVolunteer(volunteerId: number) {
    const volunteer = await this.prisma.volunteer.delete({
      where: {
        id: volunteerId,
      },
    });

    if (!volunteer) {
      throw new UserNotFoundException('Volunteer with given ID cannot be found.');
    }

    return volunteer;
  }
}
