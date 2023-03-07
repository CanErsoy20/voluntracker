import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { NeededVolunteerService } from './needed-volunteer.service';
import { CreateNeededVolunteerDto } from './dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from './dto/update-needed-volunteer.dto';

@Controller('needed-volunteer')
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
