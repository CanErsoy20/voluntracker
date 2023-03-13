import { ApiProperty } from '@nestjs/swagger';
import { IsDefined, IsEnum, IsNumber, IsOptional, IsString, Max, Min } from 'class-validator';
import { UrgencyEnum, VolunteerCategory, VolunteerType } from 'src/types';

export class CreateNeededVolunteerDto {
  @ApiProperty({ required: true, nullable: false, minimum: 1 })
  @IsDefined()
  @IsNumber()
  @Min(0)
  @Max(10000) // TODO: Maybe a different limit would be better
  quantity: number;

  @ApiProperty({ required: true, nullable: false, enum: VolunteerType })
  @IsDefined()
  @IsString()
  volunteerTypeName: VolunteerType;

  @ApiProperty({ required: true, nullable: false, enum: VolunteerCategory })
  @IsDefined()
  @IsString()
  volunteerTypeCategory: VolunteerCategory;

  @ApiProperty({ required: true, nullable: false })
  @IsDefined()
  @IsNumber()
  helpCenterId: number;

  @ApiProperty({ required: false, nullable: true, enum: UrgencyEnum })
  @IsOptional()
  @IsEnum(UrgencyEnum)
  urgency?: UrgencyEnum;
}
