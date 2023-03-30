import { IsDefined, IsNumber, IsOptional, IsSemVer, IsString } from 'class-validator';

export class AssignVolunteerToHelpCenterDto {
  @IsDefined()
  @IsNumber()
  helpCenterId: number;

  @IsNumber()
  @IsOptional()
  volunteerId?: number;

  @IsString()
  @IsOptional()
  phone?: string;

  @IsString()
  @IsOptional()
  email?: string;
}
