import { Module } from '@nestjs/common';
import { AuthModule } from 'src/authentication/auth.module';
import { UsersModule } from '../users/users.module';
import { EmailConfirmationController } from './email-confirmation.controller';
import { EmailConfirmationService } from './email-confirmation.service';
import { EmailService } from './email.service';

@Module({
  providers: [EmailService, EmailConfirmationService],
  controllers: [EmailConfirmationController],
  exports: [EmailService, EmailConfirmationService],
  imports: [UsersModule],
})
export class EmailModule {}
