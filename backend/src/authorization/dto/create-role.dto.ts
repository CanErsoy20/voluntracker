import { RolePermission } from '@prisma/client';
import { IsDefined, IsString } from 'class-validator';

export class CreateRoleDto {
  @IsString()
  @IsDefined()
  roleName: string;
}
