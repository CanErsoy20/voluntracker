import { ApiProperty } from '@nestjs/swagger';
import { SupplyCategoryEnum, SupplyTypeEnum } from '@prisma/client';

export class SupplyTypeDto {
  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Type name of the supply type.',
    example: 'Pasta',
    type: SupplyTypeEnum,
    enum: SupplyTypeEnum,
  })
  typeName: SupplyTypeEnum;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Category name of the supply type.',
    example: 'Food',
    type: SupplyCategoryEnum,
    enum: SupplyCategoryEnum,
  })
  category: SupplyCategoryEnum;
}
