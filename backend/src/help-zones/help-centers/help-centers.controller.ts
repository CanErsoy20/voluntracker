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
  ApiTags,
} from '@nestjs/swagger';
import { HelpCenter } from '@prisma/client';
import { OrderBy } from 'src/common/types';
import { CreateNeededSupplyDto } from '../needed-supply/dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from '../needed-supply/dto/update-needed-supply.dto';
import { CreateNeededVolunteerDto } from '../needed-volunteer/dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from '../needed-volunteer/dto/update-needed-volunteer.dto';
import { NeededVolunteerEntity } from '../needed-volunteer/entities/needed-volunteer.entity';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';
import { HelpCentersService } from './help-centers.service';

@ApiTags('HelpCenters')
@Controller('helpCenters')
export class HelpCentersController {
  constructor(private readonly helpCentersService: HelpCentersService) {}

  @Post()
  @ApiCreatedResponse({
    status: 200,
    type: HelpCenterEntity,
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
  @ApiCreatedResponse({
    status: 200,
    type: [HelpCenterEntity],
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

  @Get(':id')
  @ApiCreatedResponse({
    status: 200,
    type: HelpCenterEntity,
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

  @Patch(':id')
  @ApiCreatedResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully updated the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not update the help center with given id.',
  })
  async update(@Param('id') id: string, @Body() updateHelpCenterDto: UpdateHelpCenterDto) {
    const helpCenter = this.helpCentersService.update(+id, updateHelpCenterDto);

    if (!helpCenter) {
      throw new NotFoundException(
        `Update unsuccessfull: Could not find a help center with id: ${id}`,
      );
    }

    return helpCenter;
  }

  @Delete(':id')
  @ApiCreatedResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully deleted the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete the help center with given id..',
  })
  async remove(@Param('id') id: string) {
    return this.helpCentersService.remove(+id);
  }

  /* NeededVolunteers endpoints */
  @Get(':id/neededVolunteers')
  @ApiCreatedResponse({
    status: 200,
    type: [HelpCenterEntity],
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

    return neededVolunteers;
  }

  @ApiCreatedResponse({
    status: 200,
    type: [HelpCenterEntity],
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
    const neededVolunteers = await this.helpCentersService.findAllNeededVolunteersAtHelpCenter(
      +id,
      orderBy,
    );

    if (!neededVolunteers) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return neededVolunteers;
  }

  @ApiCreatedResponse({
    status: 200,
    type: [HelpCenterEntity],
    description:
      'Successfully created a needed volunteer record for the corresponding help center.',
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

    return helpCenter;
  }

  @Delete(':helpCenterId/neededVolunteers')
  async deleteAllNeededVolunteers(@Param('id') id: string) {
    return this.helpCentersService.removeAllNeededVolunteersFromHelpCenter(+id);
  }

  @Delete(':helpCenterId/neededVolunteers/:neededVolunteersId')
  async deleteNeededVolunteers(
    @Param('helpCenterId') hcId: string,
    @Param('neededVolunteersId') nvId: string,
  ) {
    return this.helpCentersService.removeNeededVolunteersFromHelpCenter(+hcId, +nvId);
  }

  @Patch(':helpCenterId/neededVolunteers/:neededVolunteersId')
  async patchNeededVolunteers(
    @Param('helpCenterId') hcId: string,
    @Param('neededVolunteersId') nvId: string,
    @Body() updateNeededVolunteerDto: UpdateNeededVolunteerDto,
  ) {
    return this.helpCentersService.updateNeededVolunteerAtHelpCenter(
      +hcId,
      +nvId,
      updateNeededVolunteerDto,
    );
  }

  /* NeededSupply endpoints */
  @Get(':id/neededSupply')
  async getNeededSupplyAtHelpCenter(@Param('id') id: string) {
    return this.helpCentersService.findAllNeededSupplyAtHelpCenter(+id);
  }

  @Get(':id/neededSupply/:orderBy')
  async getNeededSupplyAtHelpCenterByOrdering(
    @Param('id') id: string,
    @Param('orderBy') orderBy: OrderBy,
  ) {
    return this.helpCentersService.findAllNeededSupplyAtHelpCenter(+id, orderBy);
  }

  @Post(':id/neededSupply')
  async postNeededSupply(
    @Param('id') id: string,
    @Body() createNeededSupplyDto: CreateNeededSupplyDto,
  ) {
    return this.helpCentersService.addNeededSupplyToHelpCenter(+id, createNeededSupplyDto);
  }

  @Delete(':helpCenterId/neededSupply')
  async deleteAllNeededSupply(@Param('id') id: string) {
    return this.helpCentersService.removeAllNeededSupplyFromHelpCenter(+id);
  }

  @Delete(':helpCenterId/neededSupply/:neededSupplyId')
  async deleteNeededSupply(
    @Param('helpCenterId') hcId: string,
    @Param('neededSupplyId') nsId: string,
  ) {
    return this.helpCentersService.removeNeededSupplyFromHelpCenter(+hcId, +nsId);
  }

  @Patch(':helpCenterId/neededSupply/:neededSupplyId')
  async patchNeededSupply(
    @Param('helpCenterId') hcId: string,
    @Param('neededSupplyId') nsId: string,
    @Body() updateNeededSupplyDto: UpdateNeededSupplyDto,
  ) {
    return this.helpCentersService.updateNeededSupplyAtHelpCenter(
      +hcId,
      +nsId,
      updateNeededSupplyDto,
    );
  }
}
