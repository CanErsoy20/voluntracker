import { IsInt, IsDefined, IsString, IsDate } from "class-validator";
import { RolePermission } from "./";

export class Permission {
    @IsDefined()
    @IsInt()
    id!: number;

    @IsDefined()
    roles!: RolePermission[];

    @IsDefined()
    @IsString()
    permissionName!: string;

    @IsDefined()
    @IsString()
    permissionKey!: string;

    @IsDefined()
    @IsDate()
    createdAt!: Date;

    @IsDefined()
    @IsDate()
    updatedAt!: Date;
}
