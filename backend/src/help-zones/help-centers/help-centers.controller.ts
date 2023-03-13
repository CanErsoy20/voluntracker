import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
  ApiNotFoundResponse,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { HelpCenter, NeededVolunteer } from '@prisma/client';
import { OrderBy } from 'src/common/types';
import { CreateNeededSupplyDto } from '../needed-supply/dto/create-needed-supply.dto';
import { NeededSupplyDto } from '../needed-supply/dto/needed-supply.dto';
import { UpdateNeededSupplyDto } from '../needed-supply/dto/update-needed-supply.dto';
import { CreateNeededVolunteerDto } from '../needed-volunteer/dto/create-needed-volunteer.dto';
import { NeededVolunteerDto } from '../needed-volunteer/dto/needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from '../needed-volunteer/dto/update-needed-volunteer.dto';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { HelpCenterDto } from './dto/help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';
import { HelpCentersService } from './help-centers.service';

@ApiTags('HelpCenters')
@Controller('helpCenters')
export class HelpCentersController {
  constructor(private readonly helpCentersService: HelpCentersService) {}

  @Post()
  @ApiCreatedResponse({
    type: HelpCenterDto,
    description: 'Successfully created the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Help center could not be created.',
  })
  async create(@Body() createHelpCenterDto: CreateHelpCenterDto): Promise<HelpCenter> {
    const helpCenter = await this.helpCentersService.create(createHelpCenterDto);

    if (!helpCenter) {
      throw new BadRequestException('Could not create the help center.');
    }

    return helpCenter;
  }

  @Get()
  @ApiResponse({
    status: 200,
    type: [HelpCenterDto],
    description: 'Successfully found all of the help centers',
  })
  @ApiBadRequestResponse({
    description: 'Could not find all the help centers.',
  })
  async findAll(): Promise<HelpCenter[]> {
    const helpCenters = await this.helpCentersService.findAll();

    if (!helpCenters) {
      throw new NotFoundException('Could not find help center listings.');
    }

    return helpCenters;
  }
  
  @Get('all')
  @ApiResponse({
    status: 200,
    type: HelpCenterDto,
    description: 'Successfully found the help center with given id.',
  })
  async findAllHelpCenterDetails() {
    return await this.helpCentersService.findAllHelpCenterDetails();
  }

  @Get(':id')
  @ApiResponse({
    status: 200,
    type: HelpCenterDto,
    description: 'Successfully found the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  async findOne(@Param('id') id: string): Promise<HelpCenterEntity> {
    const helpCenter = await this.helpCentersService.findOne(+id);

    if (!helpCenter) {
      throw new NotFoundException(`Could not find a help center with id: ${id}`);
    }

    return helpCenter;
  }

  @Get(':id/all')
  @ApiResponse({
    status: 200,
    type: HelpCenterDto,
    description: 'Successfully found the help center with given id.',
  })
  async findHelpCenterDetails(@Param('id') id: string) {
    return await this.helpCentersService.findHelpCenterDetails(+id);
  }

  @Patch(':id')
  @ApiResponse({
    status: 200,
    type: HelpCenterDto,
    description: 'Successfully updated the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not update the help center with given id.',
  })
  async update(@Param('id') id: string, @Body() updateHelpCenterDto: UpdateHelpCenterDto) {
    const helpCenter = await this.helpCentersService.update(+id, updateHelpCenterDto);

    if (!helpCenter) {
      throw new NotFoundException(`Update unsuccessfull: Could not find a help center with id: ${id}`);
    }

    return helpCenter;
  }

  @Delete(':id')
  @ApiCreatedResponse({
    type: HelpCenterDto,
    description: 'Successfully deleted the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete the help center with given id..',
  })
  async remove(@Param('id') id: string) {
    const helpCenter = await this.helpCentersService.remove(+id);

    if (!helpCenter) {
      throw new NotFoundException(`Update unsuccessfull: Could not find a help center with id: ${id}`);
    }

    return helpCenter;
  }

  /* NeededVolunteers endpoints */
  @Get(':id/neededVolunteers')
  @ApiResponse({
    status: 200,
    type: [NeededVolunteerDto],
    description: 'Successfully found the needed volunteers for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  async getNeededVolunteersAtHelpCenter(@Param('id') id: string) {
    const neededVolunteers = await this.helpCentersService.findAllNeededVolunteersAtHelpCenter(+id);

    if (!neededVolunteers) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return neededVolunteers.map((nv) => nv.neededVolunteers);
  }

  @ApiResponse({
    status: 200,
    type: [NeededVolunteerDto],
    description: 'Successfully found the needed volunteers for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  @Get(':id/neededVolunteers/:orderBy')
  async getNeededVolunteersAtHelpCenterByOrdering(
    @Param('id') id: string,
    @Param('orderBy') orderBy: OrderBy,
  ) {
    const neededVolunteers = await this.helpCentersService.findAllNeededVolunteersAtHelpCenter(+id, orderBy);

    if (!neededVolunteers) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return neededVolunteers.map((nv) => nv.neededVolunteers);
  }

  @ApiCreatedResponse({
    type: NeededVolunteerDto,
    description: 'Successfully created a needed volunteer record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  @Post(':id/neededVolunteers')
  async postNeededVolunteers(
    @Param('id') id: string,
    @Body() createNeededVolunteerDto: CreateNeededVolunteerDto,
  ) {
    const helpCenter = await this.helpCentersService.addNeededVolunteersToHelpCenter(
      +id,
      createNeededVolunteerDto,
    );

    if (!helpCenter) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return helpCenter.neededVolunteers;
  }

  @ApiResponse({
    status: 200,
    type: NeededVolunteerDto,
    description: 'Successfully deleted ALL the needed volunteers record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  @Delete(':helpCenterId/neededVolunteers')
  async deleteAllNeededVolunteers(@Param('id') id: string) {
    const helpCenter = await this.helpCentersService.removeAllNeededVolunteersFromHelpCenter(+id);

    if (!helpCenter) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return helpCenter.neededVolunteers;
  }

  @ApiResponse({
    status: 200,
    type: NeededVolunteerDto,
    description: 'Successfully deleted the needed volunteers record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center or the needed volunteers with given id.',
  })
  @Delete(':helpCenterId/neededVolunteers/:neededVolunteersId')
  async deleteNeededVolunteers(
    @Param('helpCenterId') hcId: string,
    @Param('neededVolunteersId') nvId: string,
  ) {
    const helpCenter = await this.helpCentersService.removeNeededVolunteersFromHelpCenter(+hcId, +nvId);

    if (!helpCenter) {
      throw new NotFoundException(
        `Help center with id '${hcId}' or needed volunteers with '${nvId}' could not be found.`,
      );
    }

    return await helpCenter.neededVolunteers;
  }

  @ApiResponse({
    status: 200,
    type: NeededVolunteerDto,
    description: 'Successfully updated the needed volunteers record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center or the needed volunteers with given id.',
  })
  @Patch(':helpCenterId/neededVolunteers/:neededVolunteersId')
  async patchNeededVolunteers(
    @Param('helpCenterId') hcId: string,
    @Param('neededVolunteersId') nvId: string,
    @Body() updateNeededVolunteerDto: UpdateNeededVolunteerDto,
  ) {
    const helpCenter = await this.helpCentersService.updateNeededVolunteerAtHelpCenter(
      +hcId,
      +nvId,
      updateNeededVolunteerDto,
    );

    if (!helpCenter) {
      throw new NotFoundException(
        `Help center with id '${hcId}' or needed volunteers with '${nvId}' could not be found.`,
      );
    }

    return helpCenter;
  }

  /* NeededSupply endpoints */
  @ApiResponse({
    status: 200,
    type: [NeededSupplyDto],
    description: 'Successfully found all the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find all the needed supply for given help center.',
  })
  @Get(':id/neededSupply')
  async getAllNeededSupplyAtHelpCenter(@Param('id') id: string) {
    const helpCenter = await this.helpCentersService.findAllNeededSupplyAtHelpCenter(+id);
    return helpCenter.map((hc) => hc.neededSupply);
  }

  @ApiResponse({
    status: 200,
    type: [NeededSupplyDto],
    description: 'Successfully found all the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find all the needed supply for given help center.',
  })
  @Get(':id/neededSupply/:orderBy')
  async getAllNeededSupplyAtHelpCenterByOrdering(
    @Param('id') id: string,
    @Param('orderBy') orderBy: OrderBy,
  ) {
    const helpCenter = await this.helpCentersService.findAllNeededSupplyAtHelpCenter(+id, orderBy);
    return helpCenter.map((hc) => hc.neededSupply);
  }

  @ApiResponse({
    status: 201,
    type: NeededSupplyDto,
    description: 'Successfully created the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not create the needed supply for given help center.',
  })
  @Post(':id/neededSupply')
  async postNeededSupply(@Param('id') id: string, @Body() createNeededSupplyDto: CreateNeededSupplyDto) {
    const helpCenter = await this.helpCentersService.addNeededSupplyToHelpCenter(+id, createNeededSupplyDto);
    return helpCenter.neededSupply;
  }

  @ApiResponse({
    status: 200,
    type: NeededSupplyDto,
    description: 'Successfully deleted all the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete all the needed supply for given help center.',
  })
  @Delete(':helpCenterId/neededSupply')
  async deleteAllNeededSupply(@Param('id') id: string) {
    const helpCenter = await this.helpCentersService.removeAllNeededSupplyFromHelpCenter(+id);
    return helpCenter.neededSupply;
  }

  @ApiResponse({
    status: 200,
    type: NeededSupplyDto,
    description: 'Successfully deleted the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete the needed supply for given help center.',
  })
  @Delete(':helpCenterId/neededSupply/:neededSupplyId')
  async deleteNeededSupply(@Param('helpCenterId') hcId: string, @Param('neededSupplyId') nsId: string) {
    const helpCenter = await this.helpCentersService.removeNeededSupplyFromHelpCenter(+hcId, +nsId);
    return helpCenter.neededSupply;
  }

  @ApiResponse({
    status: 200,
    type: NeededSupplyDto,
    description: 'Successfully updated the needed volunteers record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not update  the needed supply for given help center.',
  })
  @Patch(':helpCenterId/neededSupply/:neededSupplyId')
  async patchNeededSupply(
    @Param('helpCenterId') hcId: string,
    @Param('neededSupplyId') nsId: string,
    @Body() updateNeededSupplyDto: UpdateNeededSupplyDto,
  ) {
    const helpCenter = await this.helpCentersService.updateNeededSupplyAtHelpCenter(
      +hcId,
      +nsId,
      updateNeededSupplyDto,
    );
    return helpCenter.neededSupply;
  }
}
