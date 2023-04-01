import { ApiProperty } from '@nestjs/swagger';
import { Admin, User, UserRole, Volunteer } from '@prisma/client';
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
  profileImageUrl: string;
  isEmailConfirmed: boolean;
  activationCode: string;
  @ApiProperty({
    nullable: false,
    type: Number,
    description: 'Unique identifier of the user.',
  })
  @IsDefined()
  @IsInt()
  id: number;

  @ApiProperty({
    nullable: false,
    type: String,
    description: 'First name of the user, can also contain the middle name of the user if they have one.',
  })
  @IsDefined()
  @IsString()
  firstname: string;

  @ApiProperty({
    nullable: false,
    type: String,
    description: 'Surname of the user.',
  })
  @IsDefined()
  @IsString()
  surname: string;

  @ApiProperty({
    nullable: false,
    type: String,
    description: 'Email of the user.',
  })
  @IsDefined()
  @IsString()
  email: string;

  @ApiProperty({
    nullable: false,
    type: String,
    description: 'Password of the user.',
  })
  @IsDefined()
  @IsString()
  password: string;

  @ApiProperty({
    nullable: true,
    type: String,
    description: 'Phone number of the user. It is optional.',
  })
  @IsOptional()
  @IsPhoneNumber('TR')
  phone: string;

  @ApiProperty({
    nullable: false,
    type: Number,
    description: 'Role ID of the user.',
  })
  @IsOptional()
  @IsInt()
  roleId: number;

  @ApiProperty({
    nullable: false,
    type: Object,
    description: 'Role of the user.',
  })
  @IsOptional()
  userRole: UserRole;

  @ApiProperty({
    nullable: true,
    type: Object,
    description: 'Volunteer details of the user, not null only if the user is a volunteer.',
  })
  @IsOptional()
  volunteer: Volunteer;

  @ApiProperty({
    nullable: true,
    type: Object,
    description: 'Admin details of the user, not null only if the user is an admin.',
  })
  admin: Admin;

  @ApiProperty({
    nullable: false,
    type: Object,
    description:
      'Refresh token of the user. Valid only for a specified time. Can be used to fetch new access tokens while it is valid',
  })
  @IsString()
  hashedRefreshToken: string;

  @ApiProperty({
    nullable: false,
    type: Date,
    description: 'Creation date of the user entity.',
  })
  @IsDefined()
  @IsDate()
  createdAt: Date;

  @ApiProperty({
    nullable: false,
    type: Date,
    description: 'Latest update date of the user entity.',
  })
  @IsDefined()
  @IsDate()
  updatedAt: Date;
}
