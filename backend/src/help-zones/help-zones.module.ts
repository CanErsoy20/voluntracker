import { Module } from '@nestjs/common';
import { HelpCentersModule } from './help-centers/help-centers.module';
import { NeededSupplyModule } from './needed-supply/needed-supply.module';
import { NeededVolunteerModule } from './needed-volunteer/needed-volunteer.module';
import { VolunteerModule } from './volunteer/volunteer.module';

@Module({
  imports: [HelpCentersModule, NeededVolunteerModule, NeededSupplyModule, VolunteerModule],
})
export class HelpZonesModule {}
