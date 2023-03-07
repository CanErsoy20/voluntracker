import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { NeededSupplyService } from './needed-supply.service';
import { CreateNeededSupplyDto } from './dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from './dto/update-needed-supply.dto';

@Controller('needed-supply')
export class NeededSupplyController {
  constructor(private readonly neededSupplyService: NeededSupplyService) {}

  @Post()
  create(@Body() createNeededSupplyDto: CreateNeededSupplyDto) {
    return this.neededSupplyService.create(createNeededSupplyDto);
  }

  @Get()
  findAll() {
    return this.neededSupplyService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.neededSupplyService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateNeededSupplyDto: UpdateNeededSupplyDto) {
    return this.neededSupplyService.update(+id, updateNeededSupplyDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.neededSupplyService.remove(+id);
  }
}
