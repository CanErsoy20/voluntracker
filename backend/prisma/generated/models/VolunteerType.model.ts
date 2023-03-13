import { IsString, IsDefined, IsDate } from "class-validator";
import { Volunteer, NeededVolunteer } from "./";

export class VolunteerType {
    @IsDefined()
    @IsString()
    typeName!: string;

    @IsDefined()
    @IsString()
    category!: string;

    @IsDefined()
    volunteers!: Volunteer[];

    @IsDefined()
    neededVolunteers!: NeededVolunteer[];

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
