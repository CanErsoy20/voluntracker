import { ApiProperty } from '@nestjs/swagger';
import { HelpCenter, Prisma } from '@prisma/client';

export class HelpCenterEntity implements HelpCenter {
  @ApiProperty()
  id: number;

  @ApiProperty({ required: false })
  maxVolunteers: number;

  @ApiProperty({ required: true, nullable: true })
  location: Prisma.JsonValue;

  @ApiProperty({ required: false, nullable: true })
  busiestHours: Prisma.JsonValue;

  @ApiProperty({ required: false, nullable: true })
  openCloseInfo: Prisma.JsonValue;

  @ApiProperty({ required: false, nullable: true })
  contactInfo: Prisma.JsonValue;

  @ApiProperty({ required: false, nullable: true })
  additionalInfo: string | null;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
