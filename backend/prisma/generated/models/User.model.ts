import { IsInt, IsDefined, IsString, IsOptional, IsDate } from "class-validator";
import { UserRole, Volunteer } from "./";

export class User {
    @IsDefined()
    @IsInt()
    id!: number;

    @IsDefined()
    @IsString()
    firstname!: string;

    @IsDefined()
    @IsString()
    surname!: string;

    @IsDefined()
    @IsString()
    email!: string;

    @IsOptional()
    @IsString()
    phone?: string;

    @IsDefined()
    @IsString()
    password!: string;

    @IsOptional()
    userRole?: UserRole;

    @IsOptional()
    @IsInt()
    roleId?: number;

    @IsOptional()
    volunteer?: Volunteer;

    @IsOptional()
    @IsString()
    hashedRefreshToken?: string;

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
