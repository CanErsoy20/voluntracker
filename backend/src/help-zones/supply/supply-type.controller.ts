import { Body, Controller, Delete, Get, Patch, Post } from '@nestjs/common';
import { ApiBadRequestResponse, ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { SupplyTypeDto } from './dto/create-supply-type.dto';
import { SupplyTypeEntity } from './entities/supply-type.entity';
import { SupplyTypeService } from './supply-type.service';

@ApiTags('SupplyTypes')
@Controller('supply/types')
export class SupplyTypeController {
  constructor(private readonly supplyTypeService: SupplyTypeService) {}

  @ApiOkResponse({
    description: 'Gets the supply types that are currently available in the system',
    type: [SupplyTypeEntity],
    isArray: true,
  })
  @Get()
  async getAllSupplyTypes(): Promise<HttpResponse<SupplyTypeEntity[]>> {
    const supplyTypes = await this.supplyTypeService.getAllSupplyTypes();
    return new HttpResponse(supplyTypes, 'Successfully fetched all supply types', 200);
  }

  @ApiCreatedResponse({
    description: 'Creates a new supply type.',
    type: SupplyTypeEntity,
  })
  @ApiBadRequestResponse({
    description: 'Thrown when the supply type already exists',
  })
  @Post()
  async postSupplyType(@Body() createSupplyTypeDto: SupplyTypeDto): Promise<HttpResponse<SupplyTypeEntity>> {
    const supplyType = await this.supplyTypeService.addSupplyType(createSupplyTypeDto);
    return new HttpResponse(supplyType, 'Successfully created new supply type.', 201);
  }

  @ApiOkResponse({
    description: 'Deletes an existing supply type from the system.',
    type: SupplyTypeEntity,
  })
  @Delete()
  async deleteSupplyType(@Body() supplyTypeDto: SupplyTypeDto): Promise<HttpResponse<SupplyTypeEntity>> {
    const supplyType = await this.supplyTypeService.deleteSupplyType(supplyTypeDto);
    return new HttpResponse(supplyType, 'Successfully deleted the supply type.', 200);
  }

  @ApiOkResponse({
    description: 'Updates an existing supply type in the system.',
    type: SupplyTypeEntity,
  })
  @Patch()
  async updateSupplyType(
    @Body('supplyType') supplyType: SupplyTypeDto,
    @Body('updatedSupplyType') updatedSupplyType: SupplyTypeDto,
  ): Promise<HttpResponse<SupplyTypeEntity>> {
    const st = await this.supplyTypeService.updateSupplyType(supplyType, updatedSupplyType);
    return new HttpResponse(st, 'Successfully updated the supply type', 200);
  }
}
