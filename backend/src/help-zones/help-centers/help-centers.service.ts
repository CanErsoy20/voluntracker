import { Injectable } from '@nestjs/common';
import { HelpCenter } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';

@Injectable()
export class HelpCentersService {
  constructor(private readonly prisma: PrismaService) {}

  async create(createHelpCenterDto: CreateHelpCenterDto) {
    return await this.prisma.helpCenter.create({
      data: createHelpCenterDto,
    });
  }

  async findAll() {
    return await this.prisma.helpCenter.findMany();
  }

  async findOne(id: number) {
    return await this.prisma.helpCenter.findUnique({ where: { id } });
  }

  async update(id: number, updateHelpCenterDto: UpdateHelpCenterDto) {
    return await this.prisma.helpCenter.update({
      where: { id },
      data: updateHelpCenterDto,
    });
  }

  async remove(id: number) {
    return await this.prisma.helpCenter.delete({ where: { id } });
  }
  async findAllOpen() {}

  async findAllCurrentVolunteers() {}

  async findAllSupplies() {}

  async findAllPackedSupplies() {}

  // TODO: Add to arrays, delete from arrays, reset arrays
  // TODO: Get general information
}
