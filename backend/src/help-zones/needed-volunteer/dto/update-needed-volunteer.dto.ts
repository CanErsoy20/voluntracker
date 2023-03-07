import { PartialType } from '@nestjs/mapped-types';
import { CreateNeededVolunteerDto } from './create-needed-volunteer.dto';

export class UpdateNeededVolunteerDto extends PartialType(CreateNeededVolunteerDto) {}
