import { Module } from '@nestjs/common';
import { HelpCentersModule } from './help-centers/help-centers.module';
import { SupplyModule } from './supply/supply.module';
import { TransportationModule } from './transportation/transportation.module';
import { VolunteerModule } from './volunteer/volunteer.module';

@Module({
  imports: [
    HelpCentersModule,
    VolunteerModule,
    SupplyModule,
    TransportationModule,
  ],
})
export class HelpZonesModule {}
