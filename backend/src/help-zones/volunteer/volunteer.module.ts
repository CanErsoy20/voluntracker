import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { VolunteerTypeController } from './volunteer-type.controller';
import { VolunteerTypeService } from './volunteer-type.service';

@Module({
  imports: [PrismaModule],
  providers: [VolunteerTypeService],
  controllers: [VolunteerTypeController],
})
export class VolunteerModule {}
