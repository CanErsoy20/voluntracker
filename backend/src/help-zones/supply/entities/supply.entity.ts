import { Supply } from '@prisma/client';

export class SupplyEntity implements Supply {
  id: number;
  quantity: number;
  supplyTypeName: string;
  supplyTypeCategory: string;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
