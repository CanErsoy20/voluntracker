import {
  IsDate,
  IsDateString,
  IsDecimal,
  IsDefined,
  IsNumber,
  IsOptional,
  IsString,
  IsUrl,
} from 'class-validator';

export class CreateCertificateDto {
  @IsString()
  @IsDefined()
  name: string;

  @IsOptional()
  @IsUrl()
  certificateUrl: string;

  @IsDefined()
  @IsString()
  issuer: string;

  @IsDefined()
  @IsDateString()
  issueDate: Date;
}
