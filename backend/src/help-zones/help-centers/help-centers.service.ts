import { Injectable } from '@nestjs/common';
import { HelpCenter, Prisma } from '@prisma/client';
import { DateInterval } from 'src/common/types';
import { PrismaService } from 'src/prisma/prisma.service';
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

  async addVolunteer() {}

  async addNeededVolunteer() {}

  async addSupply() {}

  async addNeededSupply() {}

  async removeVolunteer() {}

  async removeNeededVolunteer() {}

  async removeSupply() {}

  async removeNeededSupply() {}

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

  async findAllCurrentVolunteers() {}

  async findAllNeededVolunteers() {}

  async findAllSupplies() {}

  async findAllNeededSupplies() {}

  // TODO: Add to arrays, delete from arrays, reset arrays
}
