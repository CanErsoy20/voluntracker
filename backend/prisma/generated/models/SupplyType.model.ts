import { IsString, IsDefined, IsDate } from "class-validator";
import { Supply, NeededSupply } from "./";

export class SupplyType {
    @IsDefined()
    @IsString()
    typeName!: string;

    @IsDefined()
    @IsString()
    category!: string;

    @IsDefined()
    supplyReferences!: Supply[];

    @IsDefined()
    neededSupplyReferences!: NeededSupply[];

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
