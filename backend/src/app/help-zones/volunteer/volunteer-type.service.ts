import { BadRequestException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { VolunteerTypeDto } from './dto/volunteer-type.dto';

// TODO: ONLY ADMINS
@Injectable()
export class VolunteerTypeService {
  constructor(private readonly prisma: PrismaService) {}

  async getAllVolunteerTypes() {
    return await this.prisma.volunteerType.findMany();
  }

  async deleteVolunteerType(volunteerTypeDto: VolunteerTypeDto) {
    return await this.prisma.volunteerType.delete({
      where: {
        typeName_category: {
          category: volunteerTypeDto.category,
          typeName: volunteerTypeDto.typeName,
        },
      },
    });
  }

  async updateVolunteerType(volunteerTypeDto: VolunteerTypeDto, newVolunteerTypeDto: VolunteerTypeDto) {
    try {
      const supplyType = await this.prisma.volunteerType.update({
        where: {
          typeName_category: {
            category: volunteerTypeDto.category,
            typeName: volunteerTypeDto.typeName,
          },
        },
        data: newVolunteerTypeDto,
      });
      return supplyType;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException('The volunteer type with given type and category already exists.');
        }
      }
    }
  }

  async addVolunteerType(createVolunteerTypeDto: VolunteerTypeDto) {
    try {
      const volunteerType = await this.prisma.volunteerType.create({
        data: createVolunteerTypeDto,
      });
      return volunteerType;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new BadRequestException('The volunteer type with given type and category already exists.');
        }
      }
    }
  }
}
