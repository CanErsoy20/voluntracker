import { ApiProperty } from '@nestjs/swagger';
import { HelpCenter, NeededSupply, NeededVolunteer, Prisma, Supply, Volunteer } from '@prisma/client';

export class HelpCenterEntity implements HelpCenter {
  @ApiProperty()
  id: number;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Name or the title of the help center',
    examples: ['Bilkent Üniversitesi Spor Salonu'],
    minLength: 1,
    type: String,
  })
  name: string;

  @ApiProperty({
    required: true,
    nullable: false,
    description:
      'An object representing the location of the help center based on its latitude and longitude.',
    examples: [{ lat: 39.9334, lon: 32.8597 }],
    type: Object,
    properties: { lat: { type: 'Date' }, lon: { type: 'Date' } },
  })
  location: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the start and end hours for the busiests hours in a help center.',
    examples: [{ start: new Date().getHours(), end: new Date().getHours() + 1 }],
    type: Object,
    properties: { start: { type: 'Date' }, end: { type: 'Date' } },
  })
  busiestHours: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the opening and closing hours of the help center.',
    examples: [{ start: new Date().getHours(), end: new Date().getHours() + 1 }],
    type: Object,
    properties: { start: { type: 'Date' }, end: { type: 'Date' } },
  })
  openCloseInfo: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the opening and closing hours of the help center.',
    examples: [
      {
        phone: '+901111111111',
        address: 'Bilkent Üniversitesi 1598.Cadde 75.Yurt Kargo Merkezi',
        email: 'help.center@gmail.com',
      },
    ],
    type: Object,
    properties: { phone: { type: 'String' }, address: { type: 'String' }, email: { type: 'String' } },
  })
  contactInfo: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description:
      'Any additional info that is not already represented by other attributed. This might contain special information about the particular help center',
    examples: ['The help center distributes food for the volunteers.'],
    type: String,
  })
  additionalInfo: string;

  @ApiProperty({
    required: true,
    nullable: true,
    description: 'Represents the maximum number of volunteers this help center can have.',
    examples: [250],
    type: Number,
  })
  volunteerCapacity: number;

  @ApiProperty({ required: false, description: 'Volunteers assigned to the help center.' })
  volunteers?: Volunteer[];

  @ApiProperty({ required: false, description: 'Details of the volunteers that the help center needs.' })
  neededVolunteers?: NeededVolunteer[];

  @ApiProperty({ required: false, description: 'Supplies that are already stored at the help center' })
  supply?: Supply[];

  @ApiProperty({ required: false, description: 'Details of the supply that the help center needs.' })
  neededSupply?: NeededSupply[];

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
