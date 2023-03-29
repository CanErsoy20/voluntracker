import { ApiProperty } from '@nestjs/swagger';
import { VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';

export class VolunteerTypeDto {
  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Type name of the volunteer type.',
    example: 'Carrier',
    type: VolunteerTypeEnum,
    enum: VolunteerTypeEnum,
  })
  typeName: VolunteerTypeEnum;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Categpry name of the volunteer type.',
    example: 'Labor',
    type: VolunteerCategoryEnum,
    enum: VolunteerCategoryEnum,
  })
  category: VolunteerCategoryEnum;
}
