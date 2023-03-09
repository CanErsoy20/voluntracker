import { ApiProperty } from '@nestjs/swagger';
import { NeededSupply, NeededVolunteer, Prisma, Supply, Volunteer } from '@prisma/client';

export class CreateHelpCenterDto {
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
    description: 'Contains the start and end hours for the busiests hours in a help center.',
    examples: [{ start: new Date().getHours(), end: new Date().getHours() + 1 }],
    type: Object,
    properties: { start: { type: 'Date' }, end: { type: 'Date' } },
  })
  busiestHours?: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    description: 'Contains the opening and closing hours of the help center.',
    examples: [{ start: new Date().getHours(), end: new Date().getHours() + 1 }],
    type: Object,
    properties: { start: { type: 'Date' }, end: { type: 'Date' } },
  })
  openCloseInfo?: Prisma.JsonValue;

  @ApiProperty({
    required: false,
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
  contactInfo?: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    description:
      'Any additional info that is not already represented by other attributed. This might contain special information about the particular help center',
    examples: ['The help center distributes food for the volunteers.'],
    type: String,
  })
  additionalInfo?: string;

  @ApiProperty({
    required: false,
    description: 'Represents the maximum number of volunteers this help center can have.',
    examples: [250],
    type: Number,
  })
  volunteerCapacity?: number;
}
