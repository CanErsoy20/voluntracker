import { PartialType } from '@nestjs/mapped-types';
import { NeededSupply, NeededVolunteer } from '@prisma/client';
import { CreateHelpCenterDto } from './create-help-center.dto';

export class UpdateHelpCenterDto extends PartialType(CreateHelpCenterDto) {}
