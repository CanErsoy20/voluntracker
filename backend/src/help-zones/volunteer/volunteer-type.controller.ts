import { Body, Controller, Post } from '@nestjs/common';
import { CreateVolunteerTypeDto } from './dto/volunteer-type.dto';
import { VolunteerTypeService } from './volunteer-type.service';

@Controller('volunteers/types')
export class VolunteerTypeController {
  constructor(private readonly volunteerTypeService: VolunteerTypeService) {}

  @Post()
  async postVolunteerType(@Body() createVolunteerTypeDto: CreateVolunteerTypeDto) {
    return this.volunteerTypeService.addVolunteerType(createVolunteerTypeDto);
  }
}
