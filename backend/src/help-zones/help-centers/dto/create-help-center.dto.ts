import { ApiProperty } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';

export class CreateHelpCenterDto {
  @ApiProperty({ required: true, nullable: false })
  name: string;

  @ApiProperty({ required: false })
  busiestHours: Prisma.JsonObject;

  @ApiProperty({ required: false })
  openCloseInfo: Prisma.JsonObject;

  @ApiProperty({ required: false })
  location: Prisma.JsonObject;

  @ApiProperty({ required: false })
  contactInfo: Prisma.JsonObject;

  @ApiProperty({ required: false })
  additionalInfo: string;

  @ApiProperty({ required: false })
  volunteerCapacity: number;
}
