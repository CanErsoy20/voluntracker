import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateSupplyTypeDto } from './dto/create-supply-type.dto';

@Injectable()
export class SupplyTypeService {
  constructor(private readonly prisma: PrismaService) {}

  async addSupplyType(createSupplyTypeDto: CreateSupplyTypeDto) {
    try {
      const supplyType = await this.prisma.supplyType.create({
        data: createSupplyTypeDto,
      });
    } catch (e) {
      if (e instanceof PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException('The supply type with given type and category already exists.');
        }
      }
    }
  }
}
