import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import { HelpCenter, Prisma, Volunteer } from '@prisma/client';
import { UsersService } from 'src/app/users/users.service';
import { UserRolesService } from 'src/authorization/user-roles.service';
import { NotRelatedToHelpCenterException } from 'src/exceptions/not-related-to-help-center-exception.exception';
import { UniqueEntityAlreadyExistsException } from 'src/exceptions/unique-entity-already-exists-exception.exception';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { OrderBy } from 'src/types/types';
import { CreateNeededSupplyDto } from '../needed-supply/dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from '../needed-supply/dto/update-needed-supply.dto';
import { NeededSupplyService } from '../needed-supply/needed-supply.service';
import { CreateNeededVolunteerDto } from '../needed-volunteer/dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from '../needed-volunteer/dto/update-needed-volunteer.dto';
import { NeededVolunteerEntity } from '../needed-volunteer/entities/needed-volunteer.entity';
import { NeededVolunteerService } from '../needed-volunteer/needed-volunteer.service';
import { CreateCoordinatorDto } from '../volunteer/dto/create-coordinator.dto';
import { CreateVolunteerTeamDto } from '../volunteer/dto/create-volunteer-team.dto';
import { VolunteerTeamService } from '../volunteer/volunteer-team.service';
import { VolunteerService } from '../volunteer/volunteer.service';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';

@Injectable()
export class HelpCentersService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly neededVolunteerService: NeededVolunteerService,
    private readonly neededSupplyService: NeededSupplyService,
    private readonly volunteerTeamService: VolunteerTeamService,
    private readonly volunteerService: VolunteerService,
    private readonly userRolesService: UserRolesService,
    private readonly usersService: UsersService,
  ) {}
  private logger: Logger = new Logger();

  async create(createHelpCenterDto: CreateHelpCenterDto): Promise<HelpCenterEntity> {
    return await this.prisma.helpCenter.create({
      data: createHelpCenterDto,
    });
  }

  async update(id: number, updateHelpCenterDto: UpdateHelpCenterDto): Promise<HelpCenterEntity> {
    try {
      const helpCenter = await this.prisma.helpCenter.update({
        where: { id },
        data: updateHelpCenterDto,
      });
      return helpCenter;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Help center you are trying to update cannot be found in the system.',
          );
        }
      }
    }
  }

  async remove(id: number): Promise<HelpCenterEntity> {
    try {
      return await this.prisma.helpCenter.delete({ where: { id } });
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Help center you are trying to remove cannot be found in the system.',
          );
        }
      }
    }
  }

  async findAll(): Promise<HelpCenterEntity[]> {
    return await this.prisma.helpCenter.findMany({
      include: {
        neededSupply: true,
        neededVolunteers: true,
        supply: true,
        coordinator: true,
        volunteerTeams: true,
        volunteers: {
          include: {
            user: true,
            certificates: true,
            followedHelpCenters: true,
            helpCenterCoordinator: true,
            helpCenter: true,
            volunteerTeam: true,
            volunteerTeamLeader: true,
            volunteerType: true,
          },
        },
      },
    });
  }

  async findOne(id: number): Promise<HelpCenterEntity> {
    try {
      return await this.prisma.helpCenter.findUnique({
        where: { id },
        include: {
          neededSupply: true,
          neededVolunteers: true,
          supply: true,
          coordinator: true,
          volunteerTeams: true,
          volunteers: {
            include: {
              user: true,
              certificates: true,
              followedHelpCenters: true,
              helpCenterCoordinator: true,
              helpCenter: true,
              volunteerTeam: true,
              volunteerTeamLeader: true,
              volunteerType: true,
            },
          },
        },
      });
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Help center you are trying to access cannot be found in the system.',
          );
        }
      }
    }
  }

  async findAllOpen() {
    const helpCenters = await this.findAll();

    if (helpCenters.length === 0) {
      throw new UniqueEntityNotFoundException(
        'Help center you are trying to remove cannot be found in the system.',
      );
    }

    const now = Date.now();
    const openCenters = helpCenters.map((hc) => {
      const openCloseObject = hc.openCloseInfo;
      const { start, end } = openCloseObject; // TODO: Surely, there must be another way to do this?
      return now > start.getTime() && now < end.getTime();
    });

    return openCenters;
  }

  async findAllNeededVolunteersAtHelpCenter(
    helpCenterId: number,
    orderBy?: OrderBy | null,
  ): Promise<NeededVolunteerEntity[]> {
    return await this.neededVolunteerService.findAllNeededFolunteersAtTheHelpCenter(helpCenterId, orderBy);
  }

  async addNeededVolunteersToHelpCenter(
    helpCenterId: number,
    createNeededVolunteerDto: CreateNeededVolunteerDto,
  ) {
    return await this.prisma.helpCenter.update({
      where: {
        id: helpCenterId,
      },
      data: {
        neededVolunteers: {
          createMany: {
            data: [createNeededVolunteerDto],
          },
        },
      },
      include: {
        neededVolunteers: true,
        volunteerTeams: true,
      },
    });
  }

  async removeNeededVolunteersFromHelpCenter(helpCenterId: number, neededVolunteerId: number) {
    return this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededVolunteers: {
          delete: {
            id: neededVolunteerId,
          },
        },
      },
      include: {
        neededVolunteers: true,
      },
    });
  }

  async removeAllNeededVolunteersFromHelpCenter(helpCenterId: number) {
    return this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededVolunteers: {
          deleteMany: {},
        },
      },
      include: {
        neededVolunteers: true,
      },
    });
  }

  async updateNeededVolunteerAtHelpCenter(
    helpCenterId: number,
    neededVolunteerId: number,
    updateNeededVolunteerDto: UpdateNeededVolunteerDto,
  ) {
    return this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededVolunteers: {
          update: {
            where: { id: neededVolunteerId },
            data: updateNeededVolunteerDto,
          },
        },
      },
      include: {
        neededVolunteers: true,
      },
    });
  }

  async findAllNeededSupplyAtHelpCenter(helpCenterId: number, orderBy?: OrderBy | null) {
    return this.neededSupplyService.findAllNeededSupplyAtHelpCenter(helpCenterId, orderBy);
  }

  async addNeededSupplyToHelpCenter(helpCenterId: number, createNeededSupplyDto: CreateNeededSupplyDto) {
    try {
      const newSupply = await this.prisma.helpCenter.update({
        where: { id: helpCenterId },
        data: {
          neededSupply: {
            create: createNeededSupplyDto,
          },
        },
        include: { neededSupply: true },
      });
      return newSupply;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2003') {
          throw new BadRequestException(
            'The supply type you chose does not seem to exist in the system. Please make sure the given supply type and category are in the system by adding them',
          );
        }
      }
    }
  }

  async removeNeededSupplyFromHelpCenter(helpCenterId: number, neededSupplyId: number) {
    return this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededSupply: {
          delete: {
            id: neededSupplyId,
          },
        },
      },
      include: { neededSupply: true },
    });
  }

  async removeAllNeededSupplyFromHelpCenter(helpCenterId: number) {
    return this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededSupply: {
          deleteMany: {},
        },
      },
      include: { neededSupply: true },
    });
  }

  async updateNeededSupplyAtHelpCenter(
    helpCenterId: number,
    neededSupplyId: number,
    updateNeededSupplyDto: UpdateNeededSupplyDto,
  ) {
    return this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededSupply: {
          update: {
            where: { id: neededSupplyId },
            data: updateNeededSupplyDto,
          },
        },
      },
      include: { neededSupply: true },
    });
  }

  async findAllCurrentVolunteersAtHelpCenter(helpCenterId: number, orderBy?: OrderBy | null) {
    // TODO: Change this to finding all teams at the help center
    // const volunteers = await this.prisma.helpCenter.findMany({
    //   where: { id: helpCenterId },
    //   include: { volunteers: true },
    //   orderBy: {
    //     updatedAt: orderBy,
    //   },
    // });
    // return volunteers;
  }

  async findAllSuppliesAtHelpCenter(helpCenterId: number, orderBy: OrderBy | null) {
    const supplies = await this.prisma.helpCenter.findMany({
      where: { id: helpCenterId },
      include: { supply: true },
      orderBy: {
        updatedAt: orderBy,
      },
    });
    return supplies;
  }

  async findHelpCenterDetails(helpCenterId: number) {
    return await this.prisma.helpCenter.findUnique({
      where: { id: helpCenterId },
      include: {
        neededSupply: true,
        neededVolunteers: true,
        supply: true,
        coordinator: true,
        volunteerTeams: true,
        volunteers: true,
      },
    });
  }

  async findAllHelpCenterDetails() {
    return await this.prisma.helpCenter.findMany({
      include: {
        neededSupply: true,
        neededVolunteers: true,
        supply: true,
        coordinator: true,
        volunteerTeams: true,
        volunteers: true,
      },
    });
  }

  // VolunteerTeam resource endpoints
  async getAllVolunteerTeamsAtHelpCenter(helpCenterId: number) {
    return await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
      include: {
        volunteerTeams: true,
      },
    });
  }

  async createVolunteerTeamAtHelpCenter(
    helpCenterId: number,
    createVolunteerTeamDto: CreateVolunteerTeamDto,
  ) {
    const hc = await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
    });
    if (!hc) {
      throw new UniqueEntityNotFoundException('Given help center does not exist in the system.');
    }

    try {
      const updatedHc = await this.prisma.helpCenter.update({
        where: { id: helpCenterId },
        data: {
          volunteerTeams: {
            create: createVolunteerTeamDto,
          },
        },
        include: {
          volunteerTeams: true,
        },
      });
      return updatedHc;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException(`A volunteer team with the given name already exists in this help 
                                        center. Please try to use another name`);
        }
      }

      throw e;
    }
  }

  async assignVolunteerTeamToHelpCenter(hcId: number, vtId: number) {
    try {
      return await this.prisma.helpCenter.update({
        where: {
          id: hcId,
        },
        data: {
          volunteerTeams: {
            connect: { id: vtId },
          },
        },
        include: {
          volunteerTeams: true,
        },
      });
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new BadRequestException(`This help center does not exists in the system.`);
        } else if (e.code === 'P2002') {
          throw new BadRequestException(`A volunteer team with the given name already exists in this help 
                                        center. Please try to use another name.`);
        } else if (e.code === 'P2003') {
          throw new BadRequestException(
            'The volunteer team you are trying to connect does not seem to exist in the system.',
          );
        }
      }
    }
  }

  async assignVolunteerToHelpCenterWithEmail(helpCenterId: number, email: string) {
    const user = await this.usersService.findOneByEmail(email);
    const hc = await this.assignVolunteerToHelpCenter(helpCenterId, user.volunteer.id);
    return hc;
  }

  async assignVolunteerToHelpCenterWithPhone(helpCenterId: number, phone: string) {
    const user = await this.usersService.findOneByPhoneNumber(phone);
    const hc = await this.assignVolunteerToHelpCenter(helpCenterId, user.volunteer.id);
    return hc;
  }

  async assignVolunteerToHelpCenter(helpCenterId: number, volunteerId: number) {
    const helpCenter = await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
    });
    if (!helpCenter) {
      throw new UniqueEntityNotFoundException('Help center with given id cannot be found.');
    }

    const volunteer = await this.volunteerService.getVolunteer(volunteerId);
    if (volunteer.helpCenterId === helpCenterId) {
      throw new UniqueEntityAlreadyExistsException('The volunteer is already assigned to this help center.');
    }

    if (volunteer.helpCenterId !== null && volunteer.helpCenterId !== helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        `This volunteer is registered to another help center. They need to be leave that help center before being assigned to this help center.`,
      );
    }

    // Volunteer and help center connection is verified
    const updatedHelpCenter = await this.prisma.helpCenter.update({
      where: {
        id: helpCenterId,
      },
      data: {
        volunteers: {
          connect: {
            id: volunteerId,
          },
        },
      },
      include: {
        volunteers: true,
      },
    });

    return updatedHelpCenter;
  }

  // Volunteer resource endpoints
  async assignMultipleVolunteersToVolunteerTeamAtHelpCenter(
    helpCenterId: number,
    volunteerTeamId: number,
    volunteerId: string[],
  ) {
    const helpCenter = await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
    });
    if (!helpCenter) {
      throw new UniqueEntityNotFoundException('Help center with given id cannot be found.');
    }
    // We trust that volunteer team service handles exceptions related to this call
    const volunteerTeam = await this.volunteerTeamService.getVolunteerTeam(volunteerTeamId);

    if (volunteerTeam.helpCenterId === null || volunteerTeam.helpCenterId === undefined) {
      throw new NotRelatedToHelpCenterException(
        `Volunteer team is not related to any help center. Make sure the volunteer team is contained in the
        help center you are trying to assign a volunteer.`,
      );
    }

    if (volunteerTeam.helpCenterId !== helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        `Volunteer team is related to a different help center. Make sure the volunteer team is contained in the
        help center you are trying to assign a volunteer.`,
      );
    }

    const volunteerPromises = [];
    volunteerId.forEach((vid) => {
      volunteerPromises.push(this.volunteerService.getVolunteer(+vid));
    });
    const volunteers = (await Promise.all(volunteerPromises)) as Volunteer[];
    const invalidRequests = [];
    const validRequests = [];
    for (const volunteer of volunteers) {
      if (volunteer.helpCenterId === null || volunteer.helpCenterId === undefined) {
        invalidRequests.push({
          id: volunteer.id,
          message: `This volunteer is not registered to any help center. Make sure the volunteer is registered to the 
            help center before assigning them to a team.`,
        });
        continue;
      }

      if (volunteer.helpCenterId !== helpCenterId) {
        invalidRequests.push({
          id: volunteer.id,
          message: `This volunteer is registered to a different help center. Make sure the user is registered to the
        help center you are trying to access before assigning them to a team.`,
        });
        continue;
      }
      validRequests.push({ id: volunteer.id });
    }

    const connectIds = volunteers.map((v) => {
      return {
        id: v.id,
      };
    });
    const updatedHelpCenter = await this.prisma.helpCenter.update({
      where: {
        id: helpCenterId,
      },
      data: {
        volunteers: {
          connect: [...connectIds],
        },
      },
      include: {
        volunteers: true,
        volunteerTeams: true,
      },
    });

    return { validRequests, invalidRequests };
  }

  async assignVolunteerToVolunteerTeamAtHelpCenter(
    helpCenterId: number,
    volunteerTeamId: number,
    volunteerId: number,
  ) {
    const helpCenter = await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
    });
    if (!helpCenter) {
      throw new UniqueEntityNotFoundException('Help center with given id cannot be found.');
    }
    // We trust that volunteer team service handles exceptions related to this call
    const volunteerTeam = await this.volunteerTeamService.getVolunteerTeam(volunteerTeamId);

    if (volunteerTeam.helpCenterId === null || volunteerTeam.helpCenterId === undefined) {
      throw new NotRelatedToHelpCenterException(
        `Volunteer team is not related to any help center. Make sure the volunteer team is contained in the
        help center you are trying to assign a volunteer.`,
      );
    }

    if (volunteerTeam.helpCenterId !== helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        `Volunteer team iS related to a different help center. Make sure the volunteer team is contained in the
        help center you are trying to assign a volunteer.`,
      );
    }

    // We trust that volunteer service handles exceptions related to this call
    const volunteer = await this.volunteerService.getVolunteer(volunteerId);

    if (volunteer.helpCenterId === null || volunteer.helpCenterId === undefined) {
      throw new NotRelatedToHelpCenterException(
        `This volunteer is not registered to any help center. Make sure the volunteer is registered to the 
        help center before assigning them to a team.`,
      );
    }

    if (volunteer.helpCenterId !== helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        `This volunteer is registered to a different help center. Make sure the user is registered to the
         help center you are trying to access before assigning them to a team.`,
      );
    }

    const updatedHelpCenter = await this.prisma.helpCenter.update({
      where: {
        id: helpCenterId,
      },
      data: {
        volunteers: {
          connect: {
            id: volunteerId,
          },
        },
      },
      include: {
        volunteers: true,
        volunteerTeams: true,
      },
    });

    return updatedHelpCenter;
  }

  async assignCoordinatorToHelpCenter(helpCenterId: number, volunteerId: number) {
    const helpCenter = await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
      include: {
        coordinator: true,
      },
    });
    if (!helpCenter) {
      throw new UniqueEntityNotFoundException(
        'The help center cannot be assigned a coordinator because the help center record cannot be found.',
      );
    }

    // Handles volunteer not existing
    const volunteer = await this.volunteerService.getVolunteer(volunteerId);

    if (!volunteer.helpCenterId || volunteer.helpCenter === null || volunteer.helpCenter === undefined) {
      throw new NotRelatedToHelpCenterException(
        'The volunteer you are trying to assign as coordinator is not related to any help center.',
      );
    }

    if (volunteer.helpCenterId !== helpCenterId) {
      throw new NotRelatedToHelpCenterException(
        'The volunteer you are trying to assign as coordinator is not related to the given help center.',
      );
    }

    // Help center has already a coordinator
    if (helpCenter.coordinator) {
      throw new UniqueEntityAlreadyExistsException(
        'Help center already has a coordinator. You should remove the current coordinator to assign a new one.',
      );
    }

    const updatedHelpCenter = await this.prisma.helpCenter.update({
      where: {
        id: helpCenterId,
      },
      data: {
        coordinator: {
          create: {
            volunteerId: volunteerId,
          },
        },
      },
    });
    await this.userRolesService.addUserRole(volunteer.userId, 'HelpCenterCoordinator');

    return updatedHelpCenter;
  }

  async removeCoordinatorFromHelpCenter(helpCenterId: number) {
    const helpCenter = await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
      include: {
        coordinator: true,
      },
    });

    if (!helpCenter) {
      throw new UniqueEntityNotFoundException('Help center with given ID cannot be found');
    }

    if (!helpCenter.coordinator) {
      throw new UniqueEntityNotFoundException(
        'Removing coordinator from help center is unsuccessful because there is no coordinator assigned to this help center',
      );
    }

    await this.prisma.helpCenter.update({
      where: {
        id: helpCenter.id,
      },
      data: {
        coordinator: null,
      },
    });
    return await this.userRolesService.removeUserRole(
      helpCenter.coordinator.volunteerId,
      'HelpCenterCoordinator',
    );
  }
}
