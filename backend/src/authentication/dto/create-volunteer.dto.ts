import { ApiProperty } from '@nestjs/swagger';
import { VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';
import { IsEnum, IsOptional } from 'class-validator';

export class CreateVolunteerDto {
  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Type that the volunteer would prefer to work on.',
    enum: VolunteerCategoryEnum,
    example: 'Carrier',
  })
  @IsOptional()
  @IsEnum(VolunteerTypeEnum)
  volunteerTypeName: VolunteerTypeEnum;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Category that the volunteer would prefer to work on.',
    enum: VolunteerCategoryEnum,
    example: 'Labor',
  })
  @IsOptional()
  @IsEnum(VolunteerCategoryEnum)
  volunteerTypeCategory: VolunteerCategoryEnum;
}
