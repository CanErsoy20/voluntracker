import { ApiProperty } from '@nestjs/swagger';
import { UrgencyEnum, VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';
import { IsDefined, IsEnum, IsNumber, IsOptional, IsString, Max, Min } from 'class-validator';

export class CreateNeededVolunteerDto {
  @ApiProperty({ required: true, nullable: false, minimum: 1 })
  @IsDefined()
  @IsNumber()
  @Min(0)
  @Max(10000) // TODO: Maybe a different limit would be better
  quantity: number;

  @ApiProperty({ required: true, nullable: false, enum: VolunteerTypeEnum })
  @IsDefined()
  @IsString()
  volunteerTypeName: VolunteerTypeEnum;

  @ApiProperty({ required: true, nullable: false, enum: VolunteerCategoryEnum })
  @IsDefined()
  @IsString()
  volunteerTypeCategory: VolunteerCategoryEnum;

  @ApiProperty({ required: true, nullable: false })
  @IsDefined()
  @IsNumber()
  helpCenterId: number;

  @ApiProperty({ required: false, nullable: true, enum: UrgencyEnum })
  @IsOptional()
  @IsEnum(UrgencyEnum)
  urgency?: UrgencyEnum;
}
