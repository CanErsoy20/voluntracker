import { User, UserRole, Volunteer } from '@prisma/client';
import {
  IsDate,
  IsDefined,
  IsEmail,
  IsInt,
  IsOptional,
  IsPhoneNumber,
  IsString,
  MaxLength,
} from 'class-validator';

export class UserEntity implements User {
  @IsDefined()
  @IsInt()
  id: number;

  @IsDefined()
  @IsString()
  @MaxLength(50)
  firstname: string;

  @IsDefined()
  @IsString()
  @MaxLength(50)
  surname: string;

  @IsEmail()
  email: string;

  @IsDefined()
  @IsString()
  password: string;

  @IsDefined()
  @IsPhoneNumber()
  phone: string;

  @IsOptional()
  @IsInt()
  roleId: number;

  @IsOptional()
  userRole: UserRole;

  @IsOptional()
  volunteer: Volunteer;

  @IsString()
  hashedRefreshToken: string;

  @IsDefined()
  @IsDate()
  createdAt: Date;

  @IsDefined()
  @IsDate()
  updatedAt: Date;
}
