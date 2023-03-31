import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { UsersService } from '../users/users.service';
import { ConfirmEmailDto } from './dto/confirm-email.dto';
import { ResendConfirmEmailDto } from './dto/resend-confirm-email.dto';
import { EmailConfirmationService } from './email-confirmation.service';

@ApiTags('EmailConfirmation')
@Controller('emailConfirmation')
export class EmailConfirmationController {
  constructor(private readonly emailConfirmationService: EmailConfirmationService) {}

  @Post('confirm')
  async confirm(@Body() confirmationData: ConfirmEmailDto) {
    const { code, email } = confirmationData;
    const isConfirmed = this.emailConfirmationService.confirmEmailCode(email, code);

    if (!isConfirmed) {
      throw new BadRequestException('The code entered does not match the code in the database.');
    }

    return new HttpResponse({ isConfirmed }, 'Mail successfully confirmed', 200);
  }

  @Post('resendConfirmCode')
  async resend(@Body() resendConfirmEmailDto: ResendConfirmEmailDto) {
    try {
      const { email } = resendConfirmEmailDto;
      await this.emailConfirmationService.resend(email);
      return new HttpResponse(null, 'Resent the code successfully.', 200);
    } catch (e) {
      return new HttpResponse(null, 'Could not resent the code.', 400);
    }
  }
}
