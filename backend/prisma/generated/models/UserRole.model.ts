import { IsInt, IsDefined, IsString, IsDate } from "class-validator";
import { User, RolePermission } from "./";

export class UserRole {
    @IsDefined()
    @IsInt()
    id!: number;

    @IsDefined()
    @IsString()
    role_name!: string;

    @IsDefined()
    users!: User[];

    @IsDefined()
    permissions!: RolePermission[];

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
