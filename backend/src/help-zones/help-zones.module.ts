import { Module } from '@nestjs/common';
import { UsersModule } from '../users/users.module';
import { HelpCentersModule } from './help-centers/help-centers.module';
import { SupplyModule } from './supply/supply.module';
import { VolunteerModule } from './volunteer/volunteer.module';

@Module({
  imports: [HelpCentersModule, SupplyModule, VolunteerModule, UsersModule],
})
export class HelpZonesModule {}
