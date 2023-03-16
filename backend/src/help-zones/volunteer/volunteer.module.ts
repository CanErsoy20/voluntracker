import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { VolunteerTypeController } from './volunteer-type.controller';
import { VolunteerTypeService } from './volunteer-type.service';
import { VolunteerService } from './volunteer.service';
import { VolunteerController } from './volunteer.controller';

@Module({
  imports: [PrismaModule],
  providers: [VolunteerTypeService, VolunteerService],
  controllers: [VolunteerTypeController, VolunteerController],
})
export class VolunteerModule {}
