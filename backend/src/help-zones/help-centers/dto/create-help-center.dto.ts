import { ApiProperty } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';

export class CreateHelpCenterDto {
  @ApiProperty()
  location: Prisma.JsonObject;

  @ApiProperty({ required: false, nullable: true })
  maxVolunteers: number;

  @ApiProperty({ required: false })
  busiestHours: Prisma.JsonObject;

  @ApiProperty({ required: false })
  openCloseInfo: Prisma.JsonObject;

  @ApiProperty({ required: false })
  contactInfo: Prisma.JsonObject;

  @ApiProperty({ required: false })
  additionalInfo: string;
}
