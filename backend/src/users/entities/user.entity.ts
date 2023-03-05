import { User } from '@prisma/client';

export class UserEntity implements User {
  id: number;
  name: string;
  lastname: string;
  email: string;
  phone: string;
  password: string;
  roleId: number;
}
