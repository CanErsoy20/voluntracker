import { SupplyCategoryEnum, SupplyTypeEnum } from '@prisma/client';

export class CreateSupplyTypeDto {
  typeName: SupplyTypeEnum;
  category: SupplyCategoryEnum;
}
