import { ApiProperty } from '@nestjs/swagger';
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
  @ApiProperty({
    required: true,
    nullable: false,
    type: 'Number',
    description: 'Unique identifier of the user.',
  })
  @IsDefined()
  @IsInt()
  id: number;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'String',
    description: 'First name of the user, can also contain the middle name of the user if they have one.',
  })
  @IsDefined()
  @IsString()
  firstname: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'String',
    description: 'Surname of the user.',
  })
  @IsDefined()
  @IsString()
  surname: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'String',
    description: 'Email of the user.',
  })
  @IsDefined()
  @IsString()
  email: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'String',
    description: 'Password of the user.',
  })
  @IsDefined()
  @IsString()
  password: string;

  @ApiProperty({
    required: false,
    nullable: true,
    type: 'String',
    description: 'Phone number of the user. It is optional.',
  })
  @IsOptional()
  @IsPhoneNumber('TR')
  phone: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'Number',
    description: 'Role ID of the user.',
  })
  @IsOptional()
  @IsInt()
  roleId: number;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'UserRole',
    description: 'Role of the user.',
  })
  @IsOptional()
  userRole: UserRole;

  @ApiProperty({
    required: false,
    nullable: true,
    type: 'Volunteer',
    description: 'Volunteer details of the user.',
  })
  @IsOptional()
  volunteer: Volunteer;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'String',
    description:
      'Refresh token of the user. Valid only for a specified time. Can be used to fetch new access tokens while it is valid',
  })
  @IsString()
  hashedRefreshToken: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'Date',
    description: 'Creation date of the user entity.',
  })
  @IsDefined()
  @IsDate()
  createdAt: Date;

  @ApiProperty({
    required: true,
    nullable: false,
    type: 'Date',
    description: 'Latest update date of the user entity.',
  })
  @IsDefined()
  @IsDate()
  updatedAt: Date;
}
