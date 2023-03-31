import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createTransport } from 'nodemailer';
import Mail from 'nodemailer/lib/mailer';
import { UsersService } from '../users/users.service';
import { EmailService } from './email.service';

@Injectable()
export class EmailConfirmationService {
  constructor(
    private readonly configService: ConfigService,
    private readonly emailService: EmailService,
    private readonly usersService: UsersService,
  ) {}

  sendConfirmationCode(email: string, code = null) {
    if (!code) {
      code = String(this.generateConfirmationCode());
      this.usersService.assignConfirmationCode(email, code);
    }
    const text = `Welcome to Voluntracker! To confirm your email address, please enter the following code in your application: ${code}`;
    const subject = 'Voluntracker: Email confirmation';

    this.emailService.sendMail({
      to: email,
      subject,
      text,
    });
    return code;
  }

  async resend(email: string) {
    const user = await this.usersService.findOneByEmail(email);
    if (user.activationCode === null || user.activationCode === '' || user.activationCode === undefined) {
      return this.sendConfirmationCode(email);
    } else {
      return this.sendConfirmationCode(email, user.activationCode);
    }
  }

  async confirmEmailCode(email: string, code: string) {
    const user = await this.usersService.findOneByEmail(email);

    if (user.activationCode === code) {
      await this.usersService.confirmAccount(email);
      return true;
    }
    return false;
  }

  private generateConfirmationCode() {
    return Math.floor(100000 + Math.random() * 900000);
  }
}
