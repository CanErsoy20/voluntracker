import { ApiProperty } from '@nestjs/swagger';
import { SupplyCategoryEnum, SupplyType, SupplyTypeEnum } from '@prisma/client';

export class SupplyTypeEntity implements SupplyType {
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
    description: 'Type name of the supply type.',
    example: 'Food',
    type: SupplyCategoryEnum,
    enum: SupplyCategoryEnum,
  })
  category: SupplyCategoryEnum;

  @ApiProperty({ type: Date })
  createdAt: Date;

  @ApiProperty({ type: Date })
  updatedAt: Date;
}
