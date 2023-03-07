import { ApiProperty } from '@nestjs/swagger';

export class CreateNeededSupplyDto {
  @ApiProperty({ required: true, nullable: false, minimum: 1 })
  quantity: number;

  @ApiProperty({ required: true, nullable: false, enum: [] })
  supplyTypeName: string;

  @ApiProperty({ required: true, nullable: false, enum: [] })
  supplyTypeCategory: string;

  @ApiProperty({ required: false, minimum: 1, maximum: 3 })
  urgency?: number;
}
