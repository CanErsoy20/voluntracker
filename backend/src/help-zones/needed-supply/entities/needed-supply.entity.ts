import { HelpCenter, NeededSupply, SupplyType } from '@prisma/client';

export class NeededSupplyEntity implements NeededSupply {
  id: number;
  quantity: number;
  urgency: number;
  supplyTypeName: string;
  supplyTypeCategory: string;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
