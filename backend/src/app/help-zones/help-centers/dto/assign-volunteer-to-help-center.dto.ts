import { IsDefined, IsNumber, IsOptional } from 'class-validator';

export class AssignVolunteerToHelpCenterDto {
  @IsDefined()
  @IsNumber()
  helpCenterId: number;

  @IsNumber()
  @IsOptional()
  volunteerId?: number;

  @IsNumber()
  @IsOptional()
  phone?: string;

  @IsNumber()
  @IsOptional()
  email?: string;
}
