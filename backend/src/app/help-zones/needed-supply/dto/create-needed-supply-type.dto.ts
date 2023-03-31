import { IsDefined, IsSemVer, IsString } from 'class-validator';

export class CreateNeededSupplyTypeDto {
  @IsDefined()
  @IsString()
  typeName: string;

  @IsDefined()
  @IsString()
  category: string;
}
