export class NeededSupplyDto {
  id: number;
  quantity: number;
  urgency: number;
  supplyTypeName: string;
  supplyTypeCategory: string;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
