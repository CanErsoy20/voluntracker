import { PartialType } from '@nestjs/mapped-types';
import { CreateVolunteerDto } from './create-volunteer.dto';

export class UpdateVolunteerDto extends PartialType(CreateVolunteerDto) {}
