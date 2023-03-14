import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { NeededVolunteerEntity } from './entities/needed-volunteer.entity';
import { NeededVolunteerController } from './needed-volunteer.controller';
import { NeededVolunteerService } from './needed-volunteer.service';

@Module({
  imports: [PrismaModule],
  controllers: [NeededVolunteerController],
  providers: [NeededVolunteerService, NeededVolunteerEntity],
})
export class NeededVolunteerModule {}
