import { Injectable } from '@nestjs/common';
import { HelpCenter, Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { DateInterval, OrderBy } from 'src/types/types';
import { CreateNeededSupplyDto } from '../needed-supply/dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from '../needed-supply/dto/update-needed-supply.dto';
import { CreateNeededVolunteerDto } from '../needed-volunteer/dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from '../needed-volunteer/dto/update-needed-volunteer.dto';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
@Injectable()
export class HelpCentersService {
  constructor(private readonly prisma: PrismaService) {}

  async create(createHelpCenterDto: CreateHelpCenterDto): Promise<HelpCenter> {
    return await this.prisma.helpCenter.create({
      data: createHelpCenterDto,
    });
  }

  async update(id: number, updateHelpCenterDto: UpdateHelpCenterDto): Promise<HelpCenter> {
    return await this.prisma.helpCenter.update({
      where: { id },
      data: updateHelpCenterDto,
    });
  }

  async remove(id: number): Promise<HelpCenter> {
    return await this.prisma.helpCenter.delete({ where: { id } });
  }

  async findAll(): Promise<HelpCenter[]> {
    return await this.prisma.helpCenter.findMany();
  }

  async findOne(id: number): Promise<HelpCenter> {
    return await this.prisma.helpCenter.findUnique({ where: { id } });
  }

  async findAllOpen() {
    const helpCenters = await this.findAll();
    const now = Date.now();
    const openCenters = helpCenters.map((hc) => {
      const openCloseObject = hc.openCloseInfo as Prisma.JsonObject;
      const { start, end } = openCloseObject as unknown as DateInterval; // TODO: Surely, there must be another way to do this?
      return now > start.getTime() && now < end.getTime();
    });

    return openCenters;
  }

  async addVolunteer() {}

  async findAllNeededVolunteersAtHelpCenter(helpCenterId: number, orderBy?: OrderBy | null) {
    return await this.prisma.helpCenter.findMany({
      where: { id: helpCenterId },
      include: { neededVolunteers: true },
      orderBy: {
        updatedAt: orderBy,
      },
    });
  }

  async addNeededVolunteersToHelpCenter(
    helpCenterId: number,
    createNeededVolunteerDto: CreateNeededVolunteerDto,
  ) {
    return await this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededVolunteers: {
          create: createNeededVolunteerDto,
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

  async addSupply() {}

  async findAllNeededSupplyAtHelpCenter(helpCenterId: number, orderBy?: OrderBy | null) {
    const neededSupplies = await this.prisma.helpCenter.findMany({
      where: { id: helpCenterId },
      include: { neededSupply: true },
      orderBy: {
        updatedAt: orderBy,
      },
    });
    return neededSupplies;
  }

  async addNeededSupplyToHelpCenter(helpCenterId: number, createNeededSupplyDto: CreateNeededSupplyDto) {
    return await this.prisma.helpCenter.update({
      where: { id: helpCenterId },
      data: {
        neededSupply: {
          create: createNeededSupplyDto,
        },
      },
      include: { neededSupply: true },
    });
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
  async removeVolunteer() {}

  async removeSupply() {}

  async findAllCurrentVolunteersAtHelpCenter(helpCenterId: number, orderBy?: OrderBy | null) {
    const volunteers = await this.prisma.helpCenter.findMany({
      where: { id: helpCenterId },
      include: { volunteers: true },
      orderBy: {
        updatedAt: orderBy,
      },
    });
    return volunteers;
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
    return await this.prisma.helpCenter.findMany({
      where: { id: helpCenterId },
      include: {
        neededSupply: true,
        neededVolunteers: true,
        volunteers: true,
        supply: true,
      },
    });
  }

  async findAllHelpCenterDetails() {
    return await this.prisma.helpCenter.findMany({
      where: {},
      include: {
        neededSupply: true,
        neededVolunteers: true,
        volunteers: true,
        supply: true,
      },
    });
  }
}
