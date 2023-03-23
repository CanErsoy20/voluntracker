import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  Logger,
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
import { HttpResponse } from 'src/common';
import { OrderBy } from 'src/types/types';
import { CreateNeededSupplyDto } from '../needed-supply/dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from '../needed-supply/dto/update-needed-supply.dto';
import { NeededSupplyEntity } from '../needed-supply/entities/needed-supply.entity';
import { CreateNeededVolunteerDto } from '../needed-volunteer/dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from '../needed-volunteer/dto/update-needed-volunteer.dto';
import { NeededVolunteerEntity } from '../needed-volunteer/entities/needed-volunteer.entity';
import { CreateVolunteerTeamDto } from '../volunteer/dto/create-volunteer-team.dto';
import { VolunteerTeamEntity } from '../volunteer/entities/volunteer-team.entity';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';
import { HelpCentersService } from './help-centers.service';

@ApiTags('HelpCenters')
@Controller('helpCenters')
export class HelpCentersController {
  constructor(private readonly helpCentersService: HelpCentersService) {}
  private readonly logger: Logger = new Logger(HelpCentersController.name);

  @Post()
  @ApiCreatedResponse({
    type: HelpCenterEntity,
    description: 'Successfully created the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Help center could not be created.',
  })
  async create(@Body() createHelpCenterDto: CreateHelpCenterDto): Promise<HttpResponse<HelpCenterEntity>> {
    this.logger.debug(createHelpCenterDto);

    const helpCenter = await this.helpCentersService.create(createHelpCenterDto);

    if (!helpCenter) {
      throw new BadRequestException('Could not create the help center.');
    }

    return new HttpResponse<HelpCenterEntity>(helpCenter, 'Successfully created the help center', 201);
  }

  @Get()
  @ApiResponse({
    status: 200,
    type: [HelpCenterEntity],
    description: 'Successfully found all of the help centers',
  })
  @ApiBadRequestResponse({
    description: 'Could not find all the help centers.',
  })
  async findAll(): Promise<HttpResponse<HelpCenterEntity[]>> {
    const helpCenters = await this.helpCentersService.findAll();

    if (!helpCenters) {
      throw new NotFoundException('Could not find help center listings.');
    }

    return new HttpResponse<HelpCenterEntity[]>(helpCenters, 'Successfully fetched all help centers', 200);
  }

  @Get(':id')
  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully found the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  async findOne(@Param('id') id: string): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.findOne(+id);

    if (!helpCenter) {
      throw new NotFoundException(`Could not find a help center with id: ${id}`);
    }

    return new HttpResponse(helpCenter, 'Successfully fetched the help center.', 200);
  }

  @Patch(':id')
  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully updated the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not update the help center with given id.',
  })
  async update(
    @Param('id') id: string,
    @Body() updateHelpCenterDto: UpdateHelpCenterDto,
  ): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.update(+id, updateHelpCenterDto);

    if (!helpCenter) {
      throw new NotFoundException(`Update unsuccessfull: Could not find a help center with id: ${id}`);
    }

    return new HttpResponse(helpCenter, 'Successfully updated the help center.', 200);
  }

  @Delete(':id')
  @ApiCreatedResponse({
    type: HelpCenterEntity,
    description: 'Successfully deleted the help center with given id.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete the help center with given id..',
  })
  async remove(@Param('id') id: string): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.remove(+id);

    if (!helpCenter) {
      throw new NotFoundException(`Deletion unsuccessfull: Could not find a help center with id: ${id}`);
    }

    return new HttpResponse(helpCenter, 'Successfully deleted the help center.', 200);
  }

  /* NeededVolunteers endpoints */
  @Get(':id/neededVolunteers')
  @ApiResponse({
    status: 200,
    type: [NeededVolunteerEntity],
    description: 'Successfully found the needed volunteers for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  async getNeededVolunteersAtHelpCenter(
    @Param('id') id: string,
  ): Promise<HttpResponse<NeededVolunteerEntity[]>> {
    const neededVolunteers = await this.helpCentersService.findAllNeededVolunteersAtHelpCenter(+id);

    if (!neededVolunteers) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }
    return new HttpResponse(
      neededVolunteers,
      'Successfully fetched the needed volunteers for the help center.',
      200,
    );
  }

  @ApiResponse({
    status: 200,
    type: [NeededVolunteerEntity],
    description: 'Successfully found the needed volunteers for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  @Get(':id/neededVolunteers/:orderBy')
  async getNeededVolunteersAtHelpCenterByOrdering(
    @Param('id') id: string,
    @Param('orderBy') orderBy: OrderBy,
  ): Promise<HttpResponse<NeededVolunteerEntity[]>> {
    const neededVolunteers = await this.helpCentersService.findAllNeededVolunteersAtHelpCenter(+id, orderBy);

    if (!neededVolunteers) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return new HttpResponse(neededVolunteers, 'Successfully fetched the needed volunteers by ordering', 200);
  }

  @ApiCreatedResponse({
    type: HelpCenterEntity,
    description: 'Successfully created a needed volunteer record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  @Post(':id/neededVolunteers')
  async postNeededVolunteersToHelpCenter(
    @Param('id') id: string,
    @Body() createNeededVolunteerDto: CreateNeededVolunteerDto,
  ): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.addNeededVolunteersToHelpCenter(
      +id,
      createNeededVolunteerDto,
    );

    if (!helpCenter) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return new HttpResponse(helpCenter, 'Successfully added the needed volunteers', 201);
  }

  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully deleted ALL the needed volunteers record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center with given id.',
  })
  @Delete(':helpCenterId/neededVolunteers')
  async deleteAllNeededVolunteers(@Param('id') id: string): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.removeAllNeededVolunteersFromHelpCenter(+id);

    if (!helpCenter) {
      throw new NotFoundException(`Help center with id '${id}' could not be found.`);
    }

    return new HttpResponse(helpCenter, 'Successfully deleted the needed volunteers', 200);
  }

  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully deleted the needed volunteers record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find the help center or the needed volunteers with given id.',
  })
  @Delete(':helpCenterId/neededVolunteers/:neededVolunteersId')
  async deleteNeededVolunteersAtHelpCenter(
    @Param('helpCenterId') hcId: string,
    @Param('neededVolunteersId') nvId: string,
  ) {
    const helpCenter = await this.helpCentersService.removeNeededVolunteersFromHelpCenter(+hcId, +nvId);

    if (!helpCenter) {
      throw new NotFoundException(
        `Help center with id '${hcId}' or needed volunteers with '${nvId}' could not be found.`,
      );
    }

    return new HttpResponse(helpCenter, 'Successfully deleted all the needed volunteers', 200);
  }

  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
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

    return new HttpResponse(helpCenter, 'Successfully updated the needed volunteers at the help center', 200);
  }

  /* NeededSupply endpoints */
  @ApiResponse({
    status: 200,
    type: [NeededSupplyEntity],
    description: 'Successfully found all the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find all the needed supply for given help center.',
  })
  @Get(':id/neededSupply')
  async getAllNeededSupplyAtHelpCenter(@Param('id') id: string): Promise<HttpResponse<NeededSupplyEntity[]>> {
    const neededSupply = await this.helpCentersService.findAllNeededSupplyAtHelpCenter(+id);
    return new HttpResponse(
      neededSupply,
      'Successfully fetched all needed supply entities at the help center.',
      200,
    );
  }

  @ApiResponse({
    status: 200,
    type: [NeededSupplyEntity],
    description: 'Successfully found all the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not find all the needed supply for given help center.',
  })
  @Get(':id/neededSupply/:orderBy')
  async getAllNeededSupplyAtHelpCenterByOrdering(
    @Param('id') id: string,
    @Param('orderBy') orderBy: OrderBy,
  ): Promise<HttpResponse<NeededSupplyEntity[]>> {
    const neededSupply = await this.helpCentersService.findAllNeededSupplyAtHelpCenter(+id, orderBy);
    return new HttpResponse(
      neededSupply,
      'Successfully fetched all needed supply entities at the help center and ordered them.',
      200,
    );
  }

  @ApiCreatedResponse({
    type: HelpCenterEntity,
    description: 'Successfully created the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not create the needed supply for given help center.',
  })
  @Post(':id/neededSupply')
  async postNeededSupplyToHelpCenter(
    @Param('id') id: string,
    @Body() createNeededSupplyDto: CreateNeededSupplyDto,
  ): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.addNeededSupplyToHelpCenter(+id, createNeededSupplyDto);
    return new HttpResponse(helpCenter, 'Successfully added the needed supply to the help center.', 201);
  }

  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully deleted all the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete all the needed supply for given help center.',
  })
  @Delete(':helpCenterId/neededSupply')
  async deleteAllNeededSupply(@Param('id') id: string): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.removeAllNeededSupplyFromHelpCenter(+id);
    return new HttpResponse(
      helpCenter,
      'Successfully deleted all the needed supply at the help center.',
      200,
    );
  }

  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
    description: 'Successfully deleted the needed supply record for the corresponding help center.',
  })
  @ApiNotFoundResponse({
    description: 'Could not delete the needed supply for given help center.',
  })
  @Delete(':helpCenterId/neededSupply/:neededSupplyId')
  async deleteNeededSupply(
    @Param('helpCenterId') hcId: string,
    @Param('neededSupplyId') nsId: string,
  ): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.removeNeededSupplyFromHelpCenter(+hcId, +nsId);
    return new HttpResponse(
      helpCenter,
      'Successfully deleted the given needed supply at the help center.',
      200,
    );
  }

  @ApiResponse({
    status: 200,
    type: HelpCenterEntity,
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
  ): Promise<HttpResponse<HelpCenterEntity>> {
    const helpCenter = await this.helpCentersService.updateNeededSupplyAtHelpCenter(
      +hcId,
      +nsId,
      updateNeededSupplyDto,
    );
    return new HttpResponse(
      helpCenter,
      'Successfully updated the given needed supply at the help center.',
      200,
    );
  }

  // Create volunteer teams that are assigned to help centers
  @ApiResponse({
    status: 200,
    type: [VolunteerTeamEntity],
    description: 'Successfully fetched the volunteer teams for the corresponding help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not fetch the volunteer teams for given help center.',
  })
  @Get('/:hcId/volunteerTeam')
  async getAllVolunteerTeams(@Param('hcId') hcId) {
    const hcWithVolunteerTeams = await this.helpCentersService.getAllVolunteerTeams(hcId);

    if (!hcWithVolunteerTeams) {
      throw new BadRequestException('Could not find the requested resources');
    }

    const volunteerTeams = hcWithVolunteerTeams.volunteerTeams;
    return new HttpResponse(
      volunteerTeams,
      'Sucessfulyl fetched all volunteer teams in the help center',
      200,
    );
  }

  // Volunteer teams
  @ApiResponse({
    status: 201,
    type: [VolunteerTeamEntity],
    description: 'Successfully created the volunteer team for the corresponding help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not create the volunteer team for given help center.',
  })
  @Post('/:hcId/volunteerTeam')
  async createVolunteerTeam(@Param('hcId') hcId, @Body() createVolunteerTeamDto: CreateVolunteerTeamDto) {
    const hcWithVolunteerTeams = await this.helpCentersService.createVolunteerTeam(
      hcId,
      createVolunteerTeamDto,
    );

    if (!hcWithVolunteerTeams) {
      throw new BadRequestException('Could not find the requested resources');
    }

    const volunteerTeams = hcWithVolunteerTeams.volunteerTeams;
    return new HttpResponse(
      volunteerTeams,
      'Sucessfulyl created the volunteer team inside the help center',
      201,
    );
  }

  @Patch('/:helpCenterId/volunteerTeam/:volunteerTeamId')
  async assigntVolunteerTeamToHelpCenter(
    @Param('helpCenterId') hcId: number,
    @Param('volunteerTeamId') vtId: number,
  ) {
    return await this.helpCentersService.assignVolunteerTeamToHelpCenter(hcId, vtId);
  }
}
