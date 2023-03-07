import { Module } from '@nestjs/common';
import { NeededVolunteerService } from './needed-volunteer.service';
import { NeededVolunteerController } from './needed-volunteer.controller';

@Module({
  controllers: [NeededVolunteerController],
  providers: [NeededVolunteerService]
})
export class NeededVolunteerModule {}
