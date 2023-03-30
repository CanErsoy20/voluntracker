import {
  HelpCenter,
  NeededSupply,
  SupplyCategoryEnum,
  SupplyType,
  SupplyTypeEnum,
  UrgencyEnum,
} from '@prisma/client';

export class NeededSupplyEntity implements NeededSupply {
  id: number;
  quantity: number;
  urgency: UrgencyEnum;
  supplyTypeName: SupplyTypeEnum;
  supplyTypeCategory: SupplyCategoryEnum;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
