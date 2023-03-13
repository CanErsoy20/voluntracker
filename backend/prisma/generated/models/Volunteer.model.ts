import { IsInt, IsDefined, IsString, IsDate } from "class-validator";
import { User, VolunteerType, HelpCenter } from "./";

export class Volunteer {
    @IsDefined()
    @IsInt()
    id!: number;

    @IsDefined()
    user!: User;

    @IsDefined()
    @IsInt()
    userId!: number;

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
