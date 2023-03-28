import { ApiProperty } from '@nestjs/swagger';
import { IsDefined, IsEmail, IsString } from 'class-validator';

export class AuthDto {
  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Email of the user. It should be unique.',
    example: 'selimcangler@gmail.com',
    type: String,
  })
  @IsDefined()
  @IsEmail()
  email: string;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Password of the user',
    example: 'sifre123sifre',
    type: String,
  })
  @IsDefined()
  @IsString()
  password: string;
}
