import { OmitType, PartialType } from '@nestjs/swagger';
import { CreateVolunteerTeamDto } from './create-volunteer-team.dto';

export class UpdateVolunteerTeamDto extends PartialType(CreateVolunteerTeamDto) {}
