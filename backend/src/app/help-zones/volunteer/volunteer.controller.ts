import { Controller, Get, Param } from '@nestjs/common';
import { HttpResponse } from 'src/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { VolunteerService } from './volunteer.service';

@Controller('volunteers')
export class VolunteerController {
  constructor(private readonly volunteerService: VolunteerService) {}
  @Get(':id')
  async find(@Param('id') id: string) {
    const volunteer = await this.volunteerService.getVolunteer(+id);

    return new HttpResponse(volunteer, 'Successfully fetched the details for the volunteer', 200);
  }
}
