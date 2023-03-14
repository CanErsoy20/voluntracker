import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { OrderBy } from 'src/types';
import { CreateNeededVolunteerDto } from './dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from './dto/update-needed-volunteer.dto';

@Injectable()
export class NeededVolunteerService {
  constructor(private readonly prisma: PrismaService) {}

  create(createNeededVolunteerDto: CreateNeededVolunteerDto) {
    return 'This action adds a new neededVolunteer';
  }

  findAll() {
    return `This action returns all neededVolunteer`;
  }

  findOne(id: number) {
    return `This action returns a #${id} neededVolunteer`;
  }

  update(id: number, updateNeededVolunteerDto: UpdateNeededVolunteerDto) {
    return `This action updates a #${id} neededVolunteer`;
  }

  remove(id: number) {
    return `This action removes a #${id} neededVolunteer`;
  }
}
