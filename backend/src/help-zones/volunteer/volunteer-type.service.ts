import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateVolunteerTypeDto } from './dto/volunteer-type.dto';

@Injectable()
export class VolunteerTypeService {
  constructor(private readonly prisma: PrismaService) {}

  async addVolunteerType(createVolunteerTypeDto: CreateVolunteerTypeDto) {
    return this.prisma.volunteerType.create({
      data: createVolunteerTypeDto,
    });
  }
}
