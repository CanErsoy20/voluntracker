import { Module } from '@nestjs/common';
import { HelpCentersModule } from './help-centers/help-centers.module';

@Module({
  imports: [HelpCentersModule],
})
export class HelpZonesModule {}
