import { Supply, SupplyCategoryEnum, SupplyTypeEnum } from '@prisma/client';

export class SupplyEntity implements Supply {
  id: number;
  quantity: number;
  supplyTypeName: SupplyTypeEnum;
  supplyTypeCategory: SupplyCategoryEnum;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
