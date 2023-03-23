import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { HelpZonesModule } from './help-zones/help-zones.module';
import { NotificationsModule } from './notifications/notifications.module';
import { PrismaModule } from './prisma/prisma.module';
import { VolunteerTeamController } from './volunteer-team/volunteer-team.controller';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true }), PrismaModule, AuthModule, HelpZonesModule, NotificationsModule],
  controllers: [AppController],

})
export class AppModule {}
