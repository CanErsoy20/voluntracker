import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { CreateNeededSupplyDto } from './dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from './dto/update-needed-supply.dto';
import { NeededSupplyService } from './needed-supply.service';

@Controller('neededSupply')
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
