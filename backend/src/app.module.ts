import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AssetsModule } from './app/assets/assets.module';
import { HelpZonesModule } from './app/help-zones/help-zones.module';
import { NotificationsModule } from './app/notifications/notifications.module';
import { QrGeneratorModule } from './app/qr-generator/qr-generator.module';
import { AuthModule } from './authentication/auth.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    AuthModule,
    HelpZonesModule,
    NotificationsModule,
    QrGeneratorModule,
    AssetsModule,
  ],
  controllers: [],
})
export class AppModule {}
