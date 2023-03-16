import { Body, Controller, Post } from '@nestjs/common';
import { HttpResponse } from 'src/common';
import { CreateSupplyTypeDto } from './dto/create-supply-type.dto';
import { SupplyTypeService } from './supply-type.service';

@Controller('supply/types')
export class SupplyTypeController {
  constructor(private readonly supplyTypeService: SupplyTypeService) {}

  @Post()
  async postVolunteerType(@Body() createSupplyTypeDto: CreateSupplyTypeDto) {
    const supplyType = await this.supplyTypeService.addSupplyType(createSupplyTypeDto);
    return new HttpResponse(supplyType, 'Successfully created new supply type', 201);
  }
}
