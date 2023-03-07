import { Module } from '@nestjs/common';
import { UsersModule } from '../users/users.module';
import { HelpCentersModule } from './help-centers/help-centers.module';
import { SupplyModule } from './supply/supply.module';
import { VolunteerModule } from './volunteer/volunteer.module';
import { NeededVolunteerModule } from './needed-volunteer/needed-volunteer.module';
import { NeededSupplyModule } from './needed-supply/needed-supply.module';

@Module({
  imports: [HelpCentersModule, SupplyModule, VolunteerModule, UsersModule, NeededVolunteerModule, NeededSupplyModule],
})
export class HelpZonesModule {}
