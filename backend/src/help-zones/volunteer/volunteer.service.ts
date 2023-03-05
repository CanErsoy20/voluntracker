import { Injectable } from '@nestjs/common';
import { CreateVolunteerDto } from './dto/create-volunteer.dto';
import { UpdateVolunteerDto } from './dto/update-volunteer.dto';

@Injectable()
export class VolunteerService {
  create(createVolunteerDto: CreateVolunteerDto) {
    return 'This action adds a new volunteer';
  }

  findAll() {
    return `This action returns all volunteer`;
  }

  findOne(id: number) {
    return `This action returns a #${id} volunteer`;
  }

  update(id: number, updateVolunteerDto: UpdateVolunteerDto) {
    return `This action updates a #${id} volunteer`;
  }

  remove(id: number) {
    return `This action removes a #${id} volunteer`;
  }
}
