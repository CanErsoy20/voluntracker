import { ApiExtraModels, ApiProperty } from '@nestjs/swagger';
import { HelpCenter, Prisma } from '@prisma/client';
import { NeededSupplyEntity } from 'src/help-zones/needed-supply/entities/needed-supply.entity';
import { NeededVolunteerEntity } from 'src/help-zones/needed-volunteer/entities/needed-volunteer.entity';
import { SupplyEntity } from 'src/help-zones/supply/entities/supply.entity';
import { VolunteerEntity } from 'src/help-zones/volunteer/entities/volunteer.entity';

@ApiExtraModels(SupplyEntity)
@ApiExtraModels(VolunteerEntity)
@ApiExtraModels(NeededSupplyEntity)
@ApiExtraModels(NeededVolunteerEntity)
export class HelpCenterDto implements HelpCenter {
  @ApiProperty({ type: Number, example: 125 })
  id: number;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Name or the title of the help center',
    example: 'Bilkent Üniversitesi Spor Salonu',
    minLength: 1,
    type: String,
  })
  name: string;

  @ApiProperty({
    required: true,
    nullable: false,
    description:
      'An object representing the location of the help center based on its latitude and longitude.',
    example: { lat: 39.9334, lon: 32.8597 },
    type: Object,
    properties: { lat: { type: 'Number' }, lon: { type: 'Number' } },
  })
  location: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the start and end hours for the busiests hours in a help center.',
    example: {
      start: new Date().getHours() + ':' + new Date().getMinutes(),
      end: new Date().getHours() + ':' + new Date().getMinutes(),
    },
    type: Object,
    properties: { start: { type: 'String' }, end: { type: 'String' } },
  })
  busiestHours: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the opening and closing hours of the help center.',
    example: {
      start: new Date().getHours() + ':' + new Date().getMinutes(),
      end: new Date().getHours() + ':' + new Date().getMinutes(),
    },
    type: Object,
    properties: { start: { type: 'String' }, end: { type: 'String' } },
  })
  openCloseInfo: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the opening and closing hours of the help center.',
    example: {
      phone: '+901111111111',
      address: 'Bilkent Üniversitesi 1598.Cadde 75.Yurt Kargo Merkezi',
      email: 'help.center@gmail.com',
    },
    type: Object,
    properties: { phone: { type: 'String' }, address: { type: 'String' }, email: { type: 'String' } },
  })
  contactInfo: Prisma.JsonValue;

  @ApiProperty({
    required: false,
    nullable: true,
    description:
      'Any additional info that is not already represented by other attributed. This might contain special information about the particular help center',
    example: 'The help center distributes food for the volunteers.',
    type: String,
  })
  additionalInfo: string;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Represents the maximum number of volunteers this help center can have.',
    example: 250,
    type: Number,
  })
  volunteerCapacity: number;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}