import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { UsersService } from '../users/users.service';
import { ConfirmEmailDto } from './dto/confirm-email.dto';
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
}
