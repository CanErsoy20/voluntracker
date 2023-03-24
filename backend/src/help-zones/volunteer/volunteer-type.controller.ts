import { Body, Controller, Delete, Get, Patch, Post } from '@nestjs/common';
import { ApiBadRequestResponse, ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { VolunteerTypeDto } from './dto/volunteer-type.dto';
import { VolunteerTypeEntity } from './entities/volunteer-type.entity';
import { VolunteerTypeService } from './volunteer-type.service';

// TODO: POST/DELETE/PATCH CAN ONLY BE DONE BY ADMINS
@ApiTags('VolunteerTypes')
@Controller('volunteer/types')
export class VolunteerTypeController {
  constructor(private readonly volunteerTypeService: VolunteerTypeService) {}

  @ApiOkResponse({
    description: 'Gets the volunteer types that are currently available in the system',
    type: [VolunteerTypeEntity],
    isArray: true,
  })
  @Get()
  async getAllVolunteerTypes(): Promise<HttpResponse<VolunteerTypeEntity[]>> {
    const volunteerTypes = await this.volunteerTypeService.getAllVolunteerTypes();
    return new HttpResponse(volunteerTypes, 'Successfully fetched all volunteer types', 200);
  }

  @ApiCreatedResponse({
    description: 'Creates a new supply type.',
    type: VolunteerTypeEntity,
  })
  @ApiBadRequestResponse({
    description: 'Thrown when the supply type already exists',
  })
  @Post()
  async postVolunteerType(@Body() volunteerTypeDto: VolunteerTypeDto) {
    const volunteerType = await this.volunteerTypeService.addVolunteerType(volunteerTypeDto);
    return new HttpResponse(volunteerType, 'Successfully added the volunteer type.', 200);
  }

  @ApiOkResponse({
    description: 'Deletes an existing volunteer type from the system.',
    type: VolunteerTypeEntity,
  })
  @Delete()
  async deleteVolunteerType(
    @Body() volunteerTypeDto: VolunteerTypeDto,
  ): Promise<HttpResponse<VolunteerTypeEntity>> {
    const volunteerType = await this.volunteerTypeService.deleteVolunteerType(volunteerTypeDto);
    return new HttpResponse(volunteerType, 'Successfully deleted the volunteer type.', 200);
  }

  @ApiOkResponse({
    description: 'Updates an existing volunteer type in the system.',
    type: VolunteerTypeEntity,
  })
  @Patch()
  async updateVolunteerType(
    @Body('volunteerType') volunteerType: VolunteerTypeDto,
    @Body('updatedVolunteerType') updatedVolunteerType: VolunteerTypeDto,
  ): Promise<HttpResponse<VolunteerTypeEntity>> {
    const st = await this.volunteerTypeService.updateVolunteerType(volunteerType, updatedVolunteerType);
    return new HttpResponse(st, 'Successfully updated the volunteer type', 200);
  }
}
