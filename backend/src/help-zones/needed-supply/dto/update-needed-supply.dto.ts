import { PartialType } from '@nestjs/mapped-types';
import { CreateNeededSupplyDto } from './create-needed-supply.dto';

export class UpdateNeededSupplyDto extends PartialType(CreateNeededSupplyDto) {}
