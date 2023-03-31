import { OmitType } from '@nestjs/swagger';
import { ConfirmEmailDto } from './confirm-email.dto';

export class ResendConfirmEmailDto extends OmitType(ConfirmEmailDto, ['code']) {}
