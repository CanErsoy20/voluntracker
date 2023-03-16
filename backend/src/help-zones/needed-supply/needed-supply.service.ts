import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { OrderBy } from 'src/types';
import { CreateNeededSupplyDto } from './dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from './dto/update-needed-supply.dto';

@Injectable()
export class NeededSupplyService {
  constructor(private readonly prisma: PrismaService) {}

  create(createNeededSupplyDto: CreateNeededSupplyDto) {}

  findAll() {
    return `This action returns all neededSupply`;
  }

  findOne(id: number) {
    return `This action returns a #${id} neededSupply`;
  }

  update(id: number, updateNeededSupplyDto: UpdateNeededSupplyDto) {
    return `This action updates a #${id} neededSupply`;
  }

  remove(id: number) {
    return `This action removes a #${id} neededSupply`;
  }

  async findAllNeededSupplyAtHelpCenter(helpCenterId: number, orderBy: OrderBy | null) {
    return this.prisma.neededSupply.findMany({
      where: { helpCenterId },
      orderBy: {
        updatedAt: orderBy,
      },
    });
  }
}
