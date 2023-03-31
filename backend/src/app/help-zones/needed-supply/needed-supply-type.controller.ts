import { Body, Controller, Get } from '@nestjs/common';
import { HttpResponse } from 'src/common';
import { CreateNeededSupplyTypeDto } from './dto/create-needed-supply-type.dto';
import { NeededSupplyTypeService } from './needed-supply-type.service';

@Controller('neededSupplyTypes')
export class NeededSupplyTypeController {
  constructor(private readonly neededSupplyTypeService: NeededSupplyTypeService) {}

  @Get()
  async getNeededSupplyTypes(@Body() createNeededSupplyTypeDto: CreateNeededSupplyTypeDto) {
    const supplyTypes = await this.neededSupplyTypeService.findAll();
    return new HttpResponse(supplyTypes, 'Fetched all the supply types.', 200);
  }
}
