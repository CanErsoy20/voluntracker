import { ApiProperty } from '@nestjs/swagger';
import { IsDefined, IsNumber } from 'class-validator';

export class CreateVolunteerLeaderDto {
  @ApiProperty({
    required: true,
    nullable: false,
    description: `ID of the user model the volunteer is related to.`,
    type: Number,
    example: 222,
  })
  @IsDefined()
  @IsNumber()
  userId: number;

  @ApiProperty({
    required: true,
    nullable: false,
    description: `ID of the team that volunteer will lead.`,
    type: Number,
    example: 55,
  })
  @IsDefined()
  @IsNumber()
  volunteerTeamId: number;
}
