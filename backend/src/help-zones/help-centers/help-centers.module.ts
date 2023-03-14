import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { HelpZonesModule } from '../help-zones.module';
import { NeededSupplyService } from '../needed-supply/needed-supply.service';
import { NeededVolunteerService } from '../needed-volunteer/needed-volunteer.service';
import { HelpCentersController } from './help-centers.controller';
import { HelpCentersService } from './help-centers.service';

@Module({
  controllers: [HelpCentersController],
  providers: [HelpCentersService, NeededVolunteerService, NeededSupplyService],
  imports: [PrismaModule],
})
export class HelpCentersModule {}
