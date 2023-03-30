import { ApiProperty } from '@nestjs/swagger';
import { GuestVolunteer, Volunteer, VolunteerTeamLeader } from '@prisma/client';
import { IsArray, IsDefined, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateVolunteerTeamDto {
  @ApiProperty({
    required: false,
    nullable: true,
    description: `Team name can be provided to distinguish teams within a help center. The team names within
                a help center must be unique. This field will be assigned NULL, if a name is not provided`,
    example: 'Carriers in Room 3',
    minLength: 1,
    type: String,
  })
  @IsOptional()
  @IsString()
  teamName?: string;

  // @ApiProperty({
  //   required: false,
  //   nullable: true,
  //   description: `This field is optional during creation. Represents the leader of the team. A team can only
  //               have one leader. The volunteer must be picked among volunteers registered to the
  //               corresponding help center.`,
  //   minLength: 1,
  //   type: Object,
  // })
  // @IsOptional()
  // teamLeader?: VolunteerTeamLeader;

  // @ApiProperty({
  //   required: false,
  //   description: `This field is optional during creation. Volunteers that are not registered in the help
  //               center but currently helping.`,
  //   type: Array,
  //   isArray: true,
  // })
  // @IsOptional()
  // @IsArray()
  // guestVolunteer?: GuestVolunteer[];

  // @ApiProperty({
  //   required: false,
  //   description: `This field is optional during creation. Volunteers assigned to the corresponding volunteer team.`,
  //   type: Array,
  //   isArray: true,
  // })
  // @IsOptional()
  // @IsArray()
  // volunteers?: Volunteer[];
}
