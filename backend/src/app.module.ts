import { Module } from '@nestjs/common';
import { PrismaModule } from './prisma/prisma.module';
import { HelpZonesModule } from './help-zones/help-zones.module';

@Module({
  imports: [PrismaModule, HelpZonesModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
