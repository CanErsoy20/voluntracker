import { ApiProperty } from '@nestjs/swagger';
import { SupplyCategoryEnum, SupplyTypeEnum, UrgencyEnum } from '@prisma/client';
import { IsDefined, IsEnum, IsNumber, IsOptional, IsString, Max, Min } from 'class-validator';

export class CreateNeededSupplyDto {
  @ApiProperty({ required: true, nullable: false, minimum: 1 })
  @IsDefined()
  @IsNumber()
  @Min(0)
  @Max(10000) // TODO: Maybe a different limit would be better
  quantity: number;

  @ApiProperty({ required: true, nullable: false, enum: SupplyTypeEnum })
  @IsDefined()
  @IsEnum(SupplyTypeEnum)
  supplyTypeName: SupplyTypeEnum;

  @ApiProperty({ required: true, nullable: false, enum: SupplyCategoryEnum })
  @IsDefined()
  @IsEnum(SupplyCategoryEnum)
  supplyTypeCategory: SupplyCategoryEnum;

  @ApiProperty({ required: false, nullable: true, enum: UrgencyEnum })
  @IsOptional()
  @IsEnum(UrgencyEnum)
  urgency?: UrgencyEnum;
}
