import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class NeededSupplyTypeService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    const supplyTypes = await this.prisma.supplyType.findMany();
    return supplyTypes;
  }
}
