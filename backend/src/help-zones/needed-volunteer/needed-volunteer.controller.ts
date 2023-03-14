import { Body, Controller, Delete, Get, NotFoundException, Param, Patch, Post } from '@nestjs/common';
import { ApiCreatedResponse, ApiNotFoundResponse, ApiResponse } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { OrderBy } from 'src/types';
import { CreateNeededVolunteerDto } from './dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from './dto/update-needed-volunteer.dto';
import { NeededVolunteerEntity } from './entities/needed-volunteer.entity';
import { NeededVolunteerService } from './needed-volunteer.service';

@Controller('neededVolunteers')
export class NeededVolunteerController {
  constructor(private readonly neededVolunteerService: NeededVolunteerService) {}

  @Post()
  create(@Body() createNeededVolunteerDto: CreateNeededVolunteerDto) {
    return this.neededVolunteerService.create(createNeededVolunteerDto);
  }

  @Get()
  findAll() {
    return this.neededVolunteerService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.neededVolunteerService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateNeededVolunteerDto: UpdateNeededVolunteerDto) {
    return this.neededVolunteerService.update(+id, updateNeededVolunteerDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.neededVolunteerService.remove(+id);
  }
}
