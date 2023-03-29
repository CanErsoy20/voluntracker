import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { HelpZonesModule } from './app/help-zones/help-zones.module';
import { NotificationsModule } from './app/notifications/notifications.module';
import { AuthModule } from './authentication/auth.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true, validationSchema: {} }),
    PrismaModule,
    AuthModule,
    HelpZonesModule,
    NotificationsModule,
  ],
  controllers: [],
})
export class AppModule {}
