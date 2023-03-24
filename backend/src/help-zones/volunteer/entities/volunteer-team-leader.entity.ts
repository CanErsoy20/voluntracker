import { ApiProperty } from '@nestjs/swagger';
import { User, VolunteerTeam, VolunteerTeamLeader } from '@prisma/client';
import { UserEntity } from 'src/auth/entities/user.entity';
import { VolunteerTeamEntity } from './volunteer-team.entity';

export class VolunteerTeamLeaderEntity implements VolunteerTeamLeader {
  @ApiProperty({
    description: `Unique ID of the volunteer team leader..`,
    type: Number,
    example: 222,
  })
  id: number;

  @ApiProperty({
    description: `User model the entity is related to.`,
    type: UserEntity,
  })
  user: User;

  @ApiProperty({
    description: `ID of the user model the volunteer is related to.`,
    type: Number,
    example: 222,
  })
  userId: number;

  @ApiProperty({
    description: `ID of the team that volunteer will lead.`,
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
