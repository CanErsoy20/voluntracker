import { BadRequestException, Injectable } from '@nestjs/common';
import { HelpCenter, Prisma } from '@prisma/client';
import { HttpResponse } from 'src/common';
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
import { CreateVolunteerTeamDto } from '../volunteer/dto/create-volunteer-team.dto';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';
@Injectable()
export class HelpCentersService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly neededVolunteerService: NeededVolunteerService,
    private readonly neededSupplyService: NeededSupplyService,
  ) {}

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
        volunteers: true,
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
          volunteers: true,
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

  // VolunteerTeam CRUD
  async getAllVolunteerTeams(helpCenterId: number) {
    return await this.prisma.helpCenter.findUnique({
      where: {
        id: helpCenterId,
      },
      include: {
        volunteerTeams: true,
      },
    });
  }

  async createVolunteerTeam(helpCenterId: number, createVolunteerTeamDto: CreateVolunteerTeamDto) {
    try {
      return await this.prisma.helpCenter.update({
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
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException(`A volunteer team with the given name already exists in this help 
                                        center. Please try to use another name`);
        }
      }
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
}
