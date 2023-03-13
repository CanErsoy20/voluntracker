import { ApiProperty } from '@nestjs/swagger';
import { IsDefined, IsEnum, IsNumber, IsOptional, IsString, Max, Min } from 'class-validator';
import { SupplyCategory, SupplyType, UrgencyEnum } from 'src/types';

export class CreateNeededSupplyDto {
  @ApiProperty({ required: true, nullable: false, minimum: 1 })
  @IsDefined()
  @IsNumber()
  @Min(0)
  @Max(10000) // TODO: Maybe a different limit would be better
  quantity: number;

  @ApiProperty({ required: true, nullable: false, enum: SupplyType })
  @IsDefined()
  @IsString()
  supplyTypeName: SupplyType;

  @ApiProperty({ required: true, nullable: false, enum: SupplyCategory })
  @IsDefined()
  @IsString()
  supplyTypeCategory: SupplyCategory;

  @ApiProperty({ required: true, nullable: false })
  @IsDefined()
  @IsNumber()
  helpCenterId: number;

  @ApiProperty({ required: false, nullable: true, enum: UrgencyEnum })
  @IsOptional()
  @IsEnum(UrgencyEnum)
  urgency?: UrgencyEnum;
}
