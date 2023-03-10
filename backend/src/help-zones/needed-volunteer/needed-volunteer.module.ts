import { Module } from '@nestjs/common';
import { NeededVolunteerEntity } from './entities/needed-volunteer.entity';
import { NeededVolunteerController } from './needed-volunteer.controller';
import { NeededVolunteerService } from './needed-volunteer.service';

@Module({
  controllers: [NeededVolunteerController],
  providers: [NeededVolunteerService, NeededVolunteerEntity],
})
export class NeededVolunteerModule {}
