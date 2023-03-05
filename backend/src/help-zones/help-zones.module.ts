import { Module } from '@nestjs/common';
import { HelpCentersModule } from './help-centers/help-centers.module';
import { SupplyModule } from './supply/supply.module';
import { VolunteerModule } from './volunteer/volunteer.module';
import { UserModule } from './user/user.module';

@Module({
  imports: [HelpCentersModule, SupplyModule, VolunteerModule, UserModule],
})
export class HelpZonesModule {}
