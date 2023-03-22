import { BadRequestException, Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { CreateVolunteerTeamDto } from './dto/create-volunteer-team.dto';
import { UpdateVolunteerTeamDto } from './dto/update-volunteer-team.dto';
import { VolunteerTeamService } from './volunteer-team.service';

@ApiTags('volunteerTeams')
@Controller('volunteerTeams')
export class VolunteerTeamController {
  constructor(private readonly volunteerTeamService: VolunteerTeamService) {}

  // TODO: If the volunteer team is assigned to a help center, make sure the person who is making this
  // request is either an admin or the coordinator of that help center!

  @Get(':id')
  async getVolunteerTeam(@Param('id') vtId: number) {
    const vt = await this.volunteerTeamService.getVolunteerTeam(vtId);

    if (!vt) {
      throw new BadRequestException('Something went wrong while fetching this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully fetched the volunteer team', 200);
  }

  @Post()
  async createVolunteerTeam(@Body() createVolunteerTeamDto: CreateVolunteerTeamDto) {
    const vt = await this.volunteerTeamService.createVolunteerTeam(createVolunteerTeamDto);

    if (!vt) {
      throw new BadRequestException('Something went wrong while creating this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully created the volunteer team', 201);
  }

  @Delete(':id')
  async deleteVolunteerTeam(@Param('id') vtId: number) {
    const vt = await this.volunteerTeamService.deleteVolunteerTeam(vtId);

    if (!vt) {
      throw new BadRequestException('Something went wrong while deleting this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully deleted the volunteer team', 200);
  }

  @Patch(':id')
  async updateVolunteerTeam(@Param('id') vtId: number, @Body() updateVolunteerTeam: UpdateVolunteerTeamDto) {
    const vt = await this.volunteerTeamService.updateVolunteerTeam(vtId, updateVolunteerTeam);

    if (!vt) {
      throw new BadRequestException('Something went wrong while updating this volunteer team');
    }

    return new HttpResponse(vt, 'Successfully updated the volunteer team', 200);
  }

  @Get('unassigned')
  async getUnassignedVolunteerTeams() {
    const vt = await this.volunteerTeamService.getUnassignedVolunteerTeams();

    if (!vt) {
      throw new BadRequestException('Something went wrong while fetching unassigned volunteer teams.');
    }

    return new HttpResponse(vt, 'Successfully fetched the unassigned volunteer teams', 200);
  }
}
