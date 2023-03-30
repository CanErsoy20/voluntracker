import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { ExceededMaxLimitOfItemsException } from 'src/exceptions/exceeded-max-limit-of-items.exception';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { UserNotFoundException } from 'src/exceptions/user-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateCertificateDto } from './dto/create-certificate.dto';
import { UpdateCertificateDto } from './dto/update-certificate.dto';

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

  async addCertificate(volunteerId: number, createCertificateDto: CreateCertificateDto) {
    const volunteer = await this.prisma.volunteer.findUnique({
      where: {
        id: volunteerId,
      },
      include: {
        certificates: true,
      },
    });

    if (volunteer.certificates.length >= 10) {
      throw new ExceededMaxLimitOfItemsException('Maximum number of certificates to enter is 10.');
    }

    const volunteerWithCertificate = await this.prisma.volunteer.update({
      where: {
        id: volunteerId,
      },
      data: {
        certificates: {
          create: [
            {
              ...createCertificateDto,
            },
          ],
        },
      },
      include: {
        certificates: true,
      },
    });

    return volunteerWithCertificate;
  }

  async updateCertificate(certificateId: number, updateCertificateDto: UpdateCertificateDto) {
    const certificate = await this.prisma.certificate.update({
      where: {
        id: certificateId,
      },
      data: updateCertificateDto,
      include: {
        volunteer: true,
      },
    });

    return certificate;
  }

  async deleteCertificate(certificateId: number) {
    try {
      const certificate = await this.prisma.certificate.delete({
        where: {
          id: certificateId,
        },
      });
      return certificate;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Deletion is unsuccessful. The certificate with given ID could not be found.',
          );
        }
      }
    }
  }

  async followHelpCenter(helpCenterId: number, volunteerId: number) {
    const volunteer = await this.prisma.volunteer.findUnique({
      where: {
        id: volunteerId,
      },
      include: {
        followedHelpCenters: true,
      },
    });

    if (!volunteer) {
    }

    if (volunteer.followedHelpCenters.length >= 10) {
      throw new ExceededMaxLimitOfItemsException('');
    }

    await this.prisma.volunteer.update({
      where: {
        id: volunteerId,
      },
      data: {
        followedHelpCenters: {
          create: [{ helpCenterId }],
        },
      },
    });
  }
}
