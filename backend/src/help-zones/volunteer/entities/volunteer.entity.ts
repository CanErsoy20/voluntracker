import { ApiProperty } from '@nestjs/swagger';
import {
  HelpCenter,
  HelpCenterCoordinator,
  User,
  Volunteer,
  VolunteerCategoryEnum,
  VolunteerTeam,
  VolunteerTeamLeader,
  VolunteerType,
  VolunteerTypeEnum,
} from '@prisma/client';

export class VolunteerEntity implements Volunteer {
  @ApiProperty({
    nullable: false,
    type: Number,
    description: 'Unique identifier of the volunteer.',
  })
  id: number;

  @ApiProperty({
    nullable: false,
    type: Number,
    description: 'Foreign key to the user entity this volunteer is related to.',
  })
  userId: number;

  @ApiProperty({
    nullable: false,
    type: Object,
    description: 'User object this volunteer is related to.',
  })
  user: User;

  @ApiProperty({
    nullable: false,
    description: 'Job type of this volunteer.',
    enum: VolunteerTypeEnum,
  })
  volunteerTypeName: VolunteerTypeEnum;

  @ApiProperty({
    nullable: false,
    description: 'Job category of this volunteer.',
    enum: VolunteerCategoryEnum,
  })
  volunteerTypeCategory: VolunteerCategoryEnum;

  @ApiProperty({
    nullable: false,
    description: 'VolunteerType object this volunteer is related to.',
  })
  volunteerType?: VolunteerType;

  @ApiProperty({
    nullable: true,
    type: Number,
    description:
      'Foreign key to the volunteer team entity this volunteer is related to. NULL if the volunteer is not related to any team.',
  })
  volunteerTeamId: number;

  @ApiProperty({
    nullable: false,
    description: 'VolunteerTeam object this volunteer is related to.',
  })
  volunteerTeam: VolunteerTeam;

  @ApiProperty({
    nullable: true,
    type: Number,
    description:
      'The ID of the help center the volunteer is related to. NULL if the volunteer is not related to any help center',
  })
  helpCenterId: number;

  @ApiProperty({
    nullable: false,
    description: 'HelpCenter object this volunteer is related to.',
  })
  helpCenter?: HelpCenter;

  @ApiProperty({
    nullable: false,
    type: Date,
    description: 'Creation update date of the user entity.',
  })
  createdAt: Date;

  @ApiProperty({
    nullable: false,
    type: Date,
    description: 'Latest update date of the user entity.',
  })
  updatedAt: Date;

  @ApiProperty({
    nullable: true,
    type: Object,
    description:
      'References to the team leader object this volunteer is related to. NULL if the volunteer is not a team leader.',
  })
  volunteerTeamLeader?: VolunteerTeamLeader;

  @ApiProperty({
    nullable: true,
    type: Object,
    description:
      'References to the coordinator object this volunteer is related to. NULL if the volunteer is not a coordinator.',
  })
  helpCenterCoordinator?: HelpCenterCoordinator;
}
