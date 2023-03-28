import { ApiProperty } from '@nestjs/swagger';
import { Volunteer, VolunteerTeam, VolunteerTeamLeader } from '@prisma/client';
import { VolunteerTeamEntity } from './volunteer-team.entity';
import { VolunteerEntity } from './volunteer.entity';

export class VolunteerTeamLeaderEntity implements VolunteerTeamLeader {
  userId: number;
  @ApiProperty({
    description: `Unique ID of the volunteer team leader..`,
    type: Number,
    example: 222,
  })
  id: number;

  @ApiProperty({
    description: `ID of the volunteer model the team leader is related to.`,
    type: Number,
    example: 222,
  })
  volunteerId: number;

  @ApiProperty({
    description: `Volunteer model the team leader is related to.`,
    type: VolunteerEntity,
    example: 222,
  })
  volunteer: Volunteer;

  @ApiProperty({
    description: `ID of the team that team leader will lead.`,
    type: Number,
    example: 55,
  })
  volunteerTeamId: number;

  @ApiProperty({
    description: `Volunteer team that the leader is assigned to.`,
    type: VolunteerTeamEntity,
  })
  volunteerTeam: VolunteerTeam;
}
