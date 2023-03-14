import { IsDefined, IsEmail, IsString } from 'class-validator';

export class AuthDto {
  @IsDefined()
  @IsEmail()
  email: string;

  @IsDefined()
  @IsString()
  password: string;
}
