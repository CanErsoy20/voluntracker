import { ApiProperty } from '@nestjs/swagger';
import { VolunteerCategoryEnum, VolunteerType, VolunteerTypeEnum } from '@prisma/client';

export class VolunteerTypeEntity implements VolunteerType {
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

  @ApiProperty({ type: Date })
  createdAt: Date;

  @ApiProperty({ type: Date })
  updatedAt: Date;
}
