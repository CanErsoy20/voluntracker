import { IsDefined, IsNumber } from 'class-validator';

export class CreateCoordinatorDto {
  @IsDefined()
  @IsNumber()
  volunteerId: number;

  @IsDefined()
  @IsNumber()
  helpCenterId: number;
}
