import { IsDefined, IsNumber, IsPositive, IsUrl } from 'class-validator';

export class UserImageDto {
  @IsDefined()
  @IsNumber()
  @IsPositive()
  userId: number;

  @IsDefined()
  @IsUrl()
  imageUrl: string;
}
