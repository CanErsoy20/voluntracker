import { BadRequestException, Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ApiBadRequestResponse, ApiNotFoundResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { CreateVolunteerLeaderDto } from './dto/create-volunteer-leader.dto';
import { UpdateVolunteerTeamDto } from './dto/update-volunteer-team.dto';
import { VolunteerTeamEntity } from './entities/volunteer-team.entity';
import { VolunteerTeamService } from './volunteer-team.service';

// TODO: MODIFY REQUESTS CAN ONLY BE DONE BY ADMINS OR COORDINATORS OF THE HELP CENTER OR THE TEAM LEADER OF THE SPECIFIC TEAM THAT IS BEING MODIFIED
@ApiTags('VolunteerTeams')
@Controller('volunteerTeams')
export class VolunteerTeamController {
  constructor(private readonly volunteerTeamService: VolunteerTeamService) {}

  @Get()
  async getVolunteerTeams() {
    const volunteerTeams = await this.volunteerTeamService.getAllVolunteerTeams();
    return new HttpResponse(volunteerTeams, 'Successfully fetched all the volunteer teams', 200);
  }

  @ApiOkResponse({
    description: 'Fetched the details of the volunteer team with given id',
    type: VolunteerTeamEntity,
  })
  @ApiBadRequestResponse({
    description: 'Fetch unsuccessful due to an unknown error',
  })
  @Get(':id')
  async getVolunteerTeam(@Param('id') vtId: string) {
    const vt = await this.volunteerTeamService.getVolunteerTeam(+vtId);

    if (!vt) {
      throw new BadRequestException('Something went wrong while fetching this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully fetched the volunteer team', 200);
  }

  // @ApiOkResponse({
  //   description: 'Created the volunteer team with given details',
  //   type: VolunteerTeamEntity,
  // })
  // @ApiBadRequestResponse({
  //   description: 'Creation unsuccessful due to an unknown error',
  // })
  // @Post()
  // async createVolunteerTeam(@Body() createVolunteerTeamDto: CreateVolunteerTeamDto) {
  //   const vt = await this.volunteerTeamService.createVolunteerTeam(createVolunteerTeamDto);

  //   if (!vt) {
  //     throw new BadRequestException('Something went wrong while creating this volunteer team');
  //   }

  //   return new HttpResponse(vt, 'Successfully created the volunteer team', 201);
  // }

  @ApiOkResponse({
    description: 'Deletes the volunteer team with given id',
    type: VolunteerTeamEntity,
  })
  @ApiBadRequestResponse({
    description: 'Deletion unsuccessful due to an unknown error',
  })
  @Delete(':id')
  async deleteVolunteerTeam(@Param('id') vtId: string) {
    const vt = await this.volunteerTeamService.deleteVolunteerTeam(+vtId);

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
  async updateVolunteerTeam(@Param('id') vtId: string, @Body() updateVolunteerTeam: UpdateVolunteerTeamDto) {
    const vt = await this.volunteerTeamService.updateVolunteerTeam(+vtId, updateVolunteerTeam);

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

  @ApiOkResponse({
    description: `Volunteer is assigned as team leader and the volunteer entity is removed (because it 
      is converted to volunteer team leader).`,
    type: VolunteerTeamEntity,
  })
  @ApiNotFoundResponse({
    description: `Either the volunteer team or the volunteer object cannot be found.`,
  })
  @ApiBadRequestResponse({
    description: `Possible fail scenarios: The team already has a leader; team is not related to a 
                help center; volunteer is not related to a help center; the team's and volunteers help 
                center's do not match; the volunteer is not in the same team that it is being assigned 
                to as a team leader.`,
  })
  @Post('volunteerLeader')
  async assignVolunteerAsLeaderToTeam(@Body() createVolunteerLeaderDto: CreateVolunteerLeaderDto) {
    const vt = await this.volunteerTeamService.assignVolunteerAsLeaderToTeam(createVolunteerLeaderDto);

    if (!vt) {
      throw new BadRequestException(
        'Something went wrong while assigning volunteer leader to volunteer team.',
      );
    }

    return new HttpResponse(vt, 'Successfully assigned volunteer team leader to the team.', 200);
  }

  @Delete(':volunteerTeamId/volunteerLeader')
  async removeVolunteerLeaderFromTeam(
    @Param('volunteerTeamId') volunteerTeamId: string,
    @Param('volunteerId') volunteerId: string,
  ) {
    const vt = await this.volunteerTeamService.removeVolunteerTeamLeaderFromTeam(
      +volunteerTeamId,
      +volunteerId,
    );

    if (!vt) {
      throw new BadRequestException(
        'Something went wrong while removing volunteer leader from volunteer team.',
      );
    }

    return new HttpResponse(vt, 'Successfully removed the volunteer team leader from volunteer team', 200);
  }
}
