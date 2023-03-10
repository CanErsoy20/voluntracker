import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { HelpZonesModule } from '../help-zones.module';
import { HelpCentersController } from './help-centers.controller';
import { HelpCentersService } from './help-centers.service';

@Module({
  controllers: [HelpCentersController],
  providers: [HelpCentersService],
  imports: [PrismaModule],
})
export class HelpCentersModule {}
