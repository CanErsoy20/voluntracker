import { ApiProperty } from '@nestjs/swagger';
import { IsDefined, IsOptional, IsPhoneNumber, IsString } from 'class-validator';

export class CreateUserDto {
  @ApiProperty({
    required: true,
    nullable: false,
    type: String,
    description: 'First name of the user, can also contain the middle name of the user if they have one.',
  })
  @IsDefined()
  @IsString()
  firstname: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: String,
    description: 'Surname of the user.',
  })
  @IsDefined()
  @IsString()
  surname: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: String,
    description: 'Email of the user.',
  })
  @IsDefined()
  @IsString()
  email: string;

  @ApiProperty({
    required: true,
    nullable: false,
    type: String,
    description: 'Password of the user.',
  })
  @IsDefined()
  @IsString()
  password: string;

  @ApiProperty({
    required: false,
    nullable: true,
    type: String,
    description: 'Phone number of the user. It is optional.',
  })
  @IsOptional()
  @IsPhoneNumber('TR')
  phone?: string;
}
