import { ApiProperty } from '@nestjs/swagger';
import { GuestVolunteer, Volunteer, VolunteerTeam, VolunteerTeamLeader } from '@prisma/client';

export class VolunteerTeamEntity implements VolunteerTeam {
  @ApiProperty({
    nullable: false,
    description: 'Unique identifier of the team.',
    example: 55,
    type: Number,
    minimum: 0,
  })
  id: number;

  @ApiProperty({
    nullable: false,
    description: 'Foreign key to the help center. Volunteer teams are contained within help centers.',
    example: 55,
    type: Number,
    minimum: 0,
  })
  helpCenterId: number;

  @ApiProperty({
    nullable: true,
    description: `Team name can be provided to distinguish teams within a help center. 
        The team names within a help center must be unique.`,
    example: 'Carriers in Room 3',
    minLength: 1,
    type: String,
  })
  teamName: string;

  @ApiProperty({
    nullable: true,
    description: `Represents the leader of the team. A team can only have one leader. The volunteer must
                  be picked among volunteers registered to the corresponiding help center.`,
    minLength: 1,
    type: Object,
  })
  teamLeader?: VolunteerTeamLeader;

  @ApiProperty({
    description: `Volunteers that are not registered in the help center but currently helping.`,
    type: Array,
    isArray: true,
  })
  guestVolunteer?: GuestVolunteer[];

  @ApiProperty({
    description: `Volunteers assigned to the corresponding volunteer team.`,
    type: Array,
    isArray: true,
  })
  volunteers?: Volunteer[];
}
