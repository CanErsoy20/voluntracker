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
import { QrGeneratorService } from 'src/app/qr-generator/qr-generator.service';
import { HttpResponse } from 'src/common';
import { OrderBy } from 'src/types/types';
import { CreateNeededSupplyDto } from '../needed-supply/dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from '../needed-supply/dto/update-needed-supply.dto';
import { NeededSupplyEntity } from '../needed-supply/entities/needed-supply.entity';
import { CreateNeededVolunteerDto } from '../needed-volunteer/dto/create-needed-volunteer.dto';
import { UpdateNeededVolunteerDto } from '../needed-volunteer/dto/update-needed-volunteer.dto';
import { NeededVolunteerEntity } from '../needed-volunteer/entities/needed-volunteer.entity';
import { CreateCoordinatorDto } from '../volunteer/dto/create-coordinator.dto';
import { CreateVolunteerTeamDto } from '../volunteer/dto/create-volunteer-team.dto';
import { VolunteerTeamEntity } from '../volunteer/entities/volunteer-team.entity';
import { AssignVolunteerToHelpCenterDto } from './dto/assign-volunteer-to-help-center.dto';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';
import { MultipleVolunteerAssignEntity } from './entities/multiple-volunteer-assign.entity';
import { HelpCentersService } from './help-centers.service';

@ApiTags('HelpCenters')
@Controller('helpCenters')
export class HelpCentersController {
  constructor(
    private readonly helpCentersService: HelpCentersService,
    private readonly qrGeneratorService: QrGeneratorService,
  ) {}
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
  async deleteAllNeededSupply(@Param('helpCenterId') id: string): Promise<HttpResponse<HelpCenterEntity>> {
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
  @Get('/:helpCenterId/volunteerTeam')
  async getAllVolunteerTeams(@Param('helpCenterId') hcId: string) {
    const hcWithVolunteerTeams = await this.helpCentersService.getAllVolunteerTeamsAtHelpCenter(+hcId);

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
  @Post('/:helpCenterId/volunteerTeam')
  async createVolunteerTeam(
    @Param('helpCenterId') hcId: string,
    @Body() createVolunteerTeamDto: CreateVolunteerTeamDto,
  ) {
    const hcWithVolunteerTeams = await this.helpCentersService.createVolunteerTeamAtHelpCenter(
      +hcId,
      createVolunteerTeamDto,
    );
    this.logger.log(hcWithVolunteerTeams);

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

  @ApiResponse({
    status: 201,
    type: [VolunteerTeamEntity],
    description:
      'Updated the help center so that the volunteer team with given id is assigned to the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not assign the volunteer team to the given help center.',
  })
  @Patch('/:helpCenterId/volunteerTeam/:volunteerTeamId')
  async assigntVolunteerTeamToHelpCenter(
    @Param('helpCenterId') hcId: string,
    @Param('volunteerTeamId') vtId: string,
  ) {
    const helpCenterWithVolunteerTeam = await this.helpCentersService.assignVolunteerTeamToHelpCenter(
      +hcId,
      +vtId,
    );
    const volunteerTeams = helpCenterWithVolunteerTeam.volunteerTeams;
    return new HttpResponse(
      volunteerTeams,
      'Sucessfully assigned the volunteer team to the help center',
      200,
    );
  }

  // Volunteer endpoints
  @ApiResponse({
    status: 201,
    type: [HelpCenterEntity],
    description: 'Updated the help center so that the voluntee is assigned to the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not assign the volunteer to the given help center.',
  })
  @Patch('/qr/:uuid/volunteer')
  async assignVolunteerToHelpCenterByQr(
    @Body() assignVolunteerToHelpCenter: AssignVolunteerToHelpCenterDto,
    @Param('uuid') uuid: string,
  ) {
    const hasQrExpired = await this.qrGeneratorService.checkExpiry(uuid);

    if (!hasQrExpired) {
      const helpCenter = await this.assignVolunteerToHelpCenter(assignVolunteerToHelpCenter);
      return new HttpResponse(helpCenter, 'Successfully assigned the volunteer to the help center.', 200);
    }
  }

  @ApiResponse({
    status: 200,
    type: [HelpCenterEntity],
    description: 'Updated the help center so that the voluntee is assigned to the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not assign the volunteer to the given help center.',
  })
  @Patch('/assign/volunteer')
  async assignVolunteerToHelpCenter(@Body() assignVolunteerToHelpCenterDto: AssignVolunteerToHelpCenterDto) {
    const { helpCenterId: hcid, email, phone, volunteerId } = assignVolunteerToHelpCenterDto;

    if (volunteerId) {
      const updatedHelpCenter = await this.helpCentersService.assignVolunteerToHelpCenter(+hcid, volunteerId);
      if (!updatedHelpCenter) {
        throw new BadRequestException(
          'Something went wrong while trying to assign the volunteer to the help center using ID.',
        );
      }

      return new HttpResponse(
        updatedHelpCenter,
        'Successfully assigned the volunteer to the help center.',
        200,
      );
    } else if (email) {
      const updatedHelpCenter = await this.helpCentersService.assignVolunteerToHelpCenterWithEmail(
        hcid,
        email,
      );
      if (!updatedHelpCenter) {
        throw new BadRequestException(
          'Something went wrong while trying to assign the volunteer to the help center using email.',
        );
      }

      return new HttpResponse(
        updatedHelpCenter,
        'Successfully assigned the volunteer to the help center.',
        200,
      );
    } else if (phone) {
      const updatedHelpCenter = await this.helpCentersService.assignVolunteerToHelpCenterWithPhone(
        hcid,
        phone,
      );

      if (!updatedHelpCenter) {
        throw new BadRequestException(
          'Something went wrong while trying to assign the volunteer to the help center using phone number.',
        );
      }

      return new HttpResponse(
        updatedHelpCenter,
        'Successfully assigned the volunteer to the help center.',
        200,
      );
    } else {
      throw new BadRequestException(
        'One of the following must be present in the body: volunteerId, email, phone',
      );
    }
  }

  @ApiResponse({
    status: 200,
    type: [MultipleVolunteerAssignEntity],
    description: 'Updated the help center so that the voluntee is assigned to the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not assign the volunteer to the given help center.',
  })
  @Patch('/:helpCenterId/volunteerTeam/:volunteerTeamId/volunteer/')
  async assignVolunteersToVolunteerTeamInHelpCenter(
    @Param('helpCenterId') hcid: string,
    @Param('volunteerTeamId') vtid: string,
    @Body() volunteerIds: string[],
  ) {
    const successfulEvents =
      (await this.helpCentersService.assignMultipleVolunteersToVolunteerTeamAtHelpCenter(
        +hcid,
        +vtid,
        volunteerIds,
      )) as MultipleVolunteerAssignEntity;

    return new HttpResponse(successfulEvents, 'Multiple', 200);
  }

  @ApiResponse({
    status: 200,
    type: [HelpCenterEntity],
    description: 'Updated the help center so that the volunteer is assigned to the team at the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not assign the volunteer to the given team at the help center.',
  })
  @Patch('/:helpCenterId/volunteerTeam/:volunteerTeamId/volunteer/:volunteerId')
  async assignVolunteerToVolunteerTeamInHelpCenter(
    @Param('helpCenterId') hcid: string,
    @Param('volunteerTeamId') vtid: string,
    @Param('volunteerId') vid: string,
  ) {
    const updatedHelpCenter = await this.helpCentersService.assignVolunteerToVolunteerTeamAtHelpCenter(
      +hcid,
      +vtid,
      +vid,
    );

    if (!updatedHelpCenter) {
      throw new BadRequestException(
        'Something went wrong while trying to assign the volunteer to the volunteer team.',
      );
    }

    return new HttpResponse(
      updatedHelpCenter,
      'Successfully assigned the volunteer to the help center.',
      200,
    );
  }

  /* Help center coordinator end points */
  @ApiResponse({
    status: 200,
    type: [HelpCenterEntity],
    description:
      'Deleted the coordinator from the help center so that the volunteer is assigned to the team at the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not delete the coordinator at the help center.',
  })
  @Delete('/remove/helpCenterCoordinator/:volunteerId')
  async deleteCoordinatorFromHelpCenter(@Param('helpCenterId') hcid: string) {
    const hc = await this.helpCentersService.removeCoordinatorFromHelpCenter(+hcid);

    if (!hc) {
      throw new BadRequestException('Something went wrong while trying to delete the coordinator');
    }

    return new HttpResponse(hc, 'Successfully removed coordinator from help center.', 200);
  }

  @ApiResponse({
    status: 200,
    type: [HelpCenterEntity],
    description: 'Assigned the coordinator to the help center.',
  })
  @ApiBadRequestResponse({
    description: 'Could not assign the coordinator to the help center.',
  })
  @Post('/:helpCenterId/helpCenterCoordinator/:volunteerId')
  async assignCoordinatorToHelpCenter(
    @Param('helpCenterId') helpCenterId: string,
    @Param('volunteerId') volunteerId: string,
  ) {
    const helpCenterWithCoordinator = await this.helpCentersService.assignCoordinatorToHelpCenter(
      +helpCenterId,
      +volunteerId,
    );

    if (!helpCenterWithCoordinator) {
      throw new BadRequestException(
        'Something went wrong while trying to assign the coordinator to the help center',
      );
    }

    return new HttpResponse(
      helpCenterWithCoordinator,
      'Successfully assigned coordinator to the given help center.',
      200,
    );
  }
}
