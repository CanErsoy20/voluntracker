import { IsInt, IsDefined, IsOptional, IsString, IsDate } from "class-validator";
import { SupplyType, HelpCenter } from "./";

export class NeededSupply {
    @IsDefined()
    @IsInt()
    id!: number;

    @IsDefined()
    @IsInt()
    quantity!: number;

    @IsOptional()
    @IsInt()
    urgency?: number;

    @IsDefined()
    supplyType!: SupplyType;

    @IsDefined()
    @IsString()
    supplyTypeName!: string;

    @IsDefined()
    @IsString()
    supplyTypeCategory!: string;

    @IsDefined()
    helpCenter!: HelpCenter;

    @IsDefined()
    @IsInt()
    helpCenterId!: number;

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
