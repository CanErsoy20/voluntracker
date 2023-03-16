import { BadRequestException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { SupplyTypeDto } from './dto/supply-type.dto';

@Injectable()
export class SupplyTypeService {
  constructor(private readonly prisma: PrismaService) {}

  async getAllSupplyTypes() {
    return await this.prisma.supplyType.findMany();
  }

  async addSupplyType(createSupplyTypeDto: SupplyTypeDto) {
    try {
      const supplyType = await this.prisma.supplyType.create({
        data: createSupplyTypeDto,
      });
      return supplyType;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException('The supply type with given type and category already exists.');
        }
      }
    }
  }

  async deleteSupplyType(supplyTypeDto: SupplyTypeDto) {
    return await this.prisma.supplyType.delete({
      where: {
        typeName_category: {
          category: supplyTypeDto.category,
          typeName: supplyTypeDto.typeName,
        },
      },
    });
  }

  async updateSupplyType(supplyTypeDto: SupplyTypeDto, newSupplyTypeDto: SupplyTypeDto) {
    try {
      const supplyType = await this.prisma.supplyType.update({
        where: {
          typeName_category: {
            category: supplyTypeDto.category,
            typeName: supplyTypeDto.typeName,
          },
        },
        data: newSupplyTypeDto,
      });
      return supplyType;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException('The supply type with given type and category already exists.');
        }
      }
    }
  }
}
