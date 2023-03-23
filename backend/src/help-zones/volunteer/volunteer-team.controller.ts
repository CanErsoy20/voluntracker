import { BadRequestException, Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ApiBadRequestResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { CreateVolunteerTeamDto } from './dto/create-volunteer-team.dto';
import { UpdateVolunteerTeamDto } from './dto/update-volunteer-team.dto';
import { VolunteerTeamEntity } from './entities/volunteer-team.entity';
import { VolunteerTeamService } from './volunteer-team.service';

@ApiTags('volunteerTeams')
@Controller('volunteerTeams')
export class VolunteerTeamController {
  constructor(private readonly volunteerTeamService: VolunteerTeamService) {}

  @ApiOkResponse({
    description: 'Fetched the details of the volunteer team with given id',
    type: VolunteerTeamEntity,
  })
  @ApiBadRequestResponse({
    description: 'Fetch unsuccessful due to an unknown error',
  })
  @Get(':id')
  async getVolunteerTeam(@Param('id') vtId: number) {
    const vt = await this.volunteerTeamService.getVolunteerTeam(vtId);

    if (!vt) {
      throw new BadRequestException('Something went wrong while fetching this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully fetched the volunteer team', 200);
  }

  @ApiOkResponse({
    description: 'Created the volunteer team with given details',
    type: VolunteerTeamEntity,
  })
  @ApiBadRequestResponse({
    description: 'Creation unsuccessful due to an unknown error',
  })
  @Post()
  async createVolunteerTeam(@Body() createVolunteerTeamDto: CreateVolunteerTeamDto) {
    const vt = await this.volunteerTeamService.createVolunteerTeam(createVolunteerTeamDto);

    if (!vt) {
      throw new BadRequestException('Something went wrong while creating this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully created the volunteer team', 201);
  }

  @ApiOkResponse({
    description: 'Deletes the volunteer team with given id',
    type: VolunteerTeamEntity,
  })
  @ApiBadRequestResponse({
    description: 'Deletion unsuccessful due to an unknown error',
  })
  @Delete(':id')
  async deleteVolunteerTeam(@Param('id') vtId: number) {
    const vt = await this.volunteerTeamService.deleteVolunteerTeam(vtId);

    if (!vt) {
      throw new BadRequestException('Something went wrong while deleting this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully deleted the volunteer team', 200);
  }

  @ApiOkResponse({
    description: 'Updates the details of the volunteer team with given id',
    type: VolunteerTeamEntity,
  })
  @ApiBadRequestResponse({
    description: 'Update unsuccessful due to an unknown error',
  })
  @Patch(':id')
  async updateVolunteerTeam(@Param('id') vtId: number, @Body() updateVolunteerTeam: UpdateVolunteerTeamDto) {
    const vt = await this.volunteerTeamService.updateVolunteerTeam(vtId, updateVolunteerTeam);

    if (!vt) {
      throw new BadRequestException('Something went wrong while updating this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully updated the volunteer team', 200);
  }

  @ApiOkResponse({
    description: 'Fetches the details of the volunteer teams that are not assigned.',
    type: [VolunteerTeamEntity],
  })
  @ApiBadRequestResponse({
    description: 'Fetch unsuccessful due to an unknown error',
  })
  @Get('unassigned')
  async getUnassignedVolunteerTeams() {
    const vt = await this.volunteerTeamService.getUnassignedVolunteerTeams();

    if (!vt) {
      throw new BadRequestException('Something went wrong while fetching unassigned volunteer teams.');
    }

    return new HttpResponse(vt, 'Successfully fetched the unassigned volunteer teams', 200);
  }
}
