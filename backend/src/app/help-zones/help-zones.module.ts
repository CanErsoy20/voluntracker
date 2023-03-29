import { Module } from '@nestjs/common';
import { AuthorizationModule } from 'src/authorization/authorization.module';
import { HelpCentersModule } from './help-centers/help-centers.module';
import { NeededSupplyModule } from './needed-supply/needed-supply.module';
import { NeededVolunteerModule } from './needed-volunteer/needed-volunteer.module';
import { SupplyModule } from './supply/supply.module';
import { VolunteerModule } from './volunteer/volunteer.module';

@Module({
  imports: [
    HelpCentersModule,
    NeededVolunteerModule,
    NeededSupplyModule,
    VolunteerModule,
    SupplyModule,
    AuthorizationModule,
  ],
  controllers: [],
})
export class HelpZonesModule {}
