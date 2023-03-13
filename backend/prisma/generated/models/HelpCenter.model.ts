import { Prisma } from '@prisma/client';
import { IsDate, IsDefined, IsInt, IsString } from 'class-validator';
import { NeededSupply, NeededVolunteer, Supply, Volunteer } from './';

export class HelpCenter {
  @IsDefined()
  @IsInt()
  id: number;

  @IsDefined()
  @IsString()
  name: string;

  @IsDefined()
  busiestHours: Prisma.JsonValue;

  @IsDefined()
  openCloseInfo: Prisma.JsonValue;

  @IsDefined()
  location: Prisma.JsonValue;

  @IsDefined()
  contactInfo: Prisma.JsonValue;

  @IsDefined()
  @IsString()
  additionalInfo: string;

  @IsDefined()
  @IsInt()
  volunteerCapacity: number;

  @IsDefined()
  @IsDate()
  createdAt: Date;

  @IsDefined()
  @IsDate()
  updatedAt: Date;

  @IsDefined()
  volunteers: Volunteer[];

  @IsDefined()
  neededVolunteers: NeededVolunteer[];

  @IsDefined()
  supply: Supply[];

  @IsDefined()
  neededSupply: NeededSupply[];
}
