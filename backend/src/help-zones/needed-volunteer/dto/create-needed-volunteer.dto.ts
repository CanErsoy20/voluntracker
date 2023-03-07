import { ApiProperty } from '@nestjs/swagger';

export class CreateNeededVolunteerDto {
  @ApiProperty({ required: true, nullable: false, minimum: 1 })
  quantity: number;

  @ApiProperty({ required: true, nullable: false })
  volunteerTypeName: string;

  @ApiProperty({ required: true, nullable: false })
  volunteerTypeCategory: string;

  @ApiProperty({ required: false, enum: ['1', '2', '3'] })
  urgency?: number;
}
