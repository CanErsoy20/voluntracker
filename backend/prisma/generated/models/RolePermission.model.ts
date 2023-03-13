import { IsInt, IsDefined, IsDate } from "class-validator";
import { Permission, UserRole } from "./";

export class RolePermission {
    @IsDefined()
    @IsInt()
    id!: number;

    @IsDefined()
    permission!: Permission;

    @IsDefined()
    @IsInt()
    permissionId!: number;

    @IsDefined()
    role!: UserRole;

    @IsDefined()
    @IsInt()
    roleId!: number;

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
