import { PartialType } from '@nestjs/mapped-types';
import {
  NeededSupplies,
  NeededVolunteers,
  PackedSupplies,
  Prisma,
  Supplies,
  Volunteer,
} from '@prisma/client';
import { CreateHelpCenterDto } from './create-help-center.dto';

export class UpdateHelpCenterDto extends PartialType(CreateHelpCenterDto) {}
