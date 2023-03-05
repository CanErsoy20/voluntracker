import { ApiProperty } from '@nestjs/swagger';
import { HelpCenter, Prisma } from '@prisma/client';

export class HelpCenterEntity implements HelpCenter {
  @ApiProperty()
  id: number;

  @ApiProperty({ required: true, nullable: false })
  name: string;

  @ApiProperty({ required: false })
  busiestHours: Prisma.JsonValue;

  @ApiProperty({ required: false })
  openCloseInfo: Prisma.JsonValue;

  @ApiProperty({ required: false })
  location: Prisma.JsonValue;

  @ApiProperty({ required: false })
  contactInfo: Prisma.JsonValue;

  @ApiProperty({ required: false })
  additionalInfo: string;

  @ApiProperty({ required: false })
  volunteerCapacity: number;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
