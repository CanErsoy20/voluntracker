import { IsInt, IsDefined, IsOptional, IsString, IsDate } from "class-validator";
import { VolunteerType, HelpCenter } from "./";

export class NeededVolunteer {
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
    volunteerType!: VolunteerType;

    @IsDefined()
    @IsString()
    volunteerTypeName!: string;

    @IsDefined()
    @IsString()
    volunteerTypeCategory!: string;

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
