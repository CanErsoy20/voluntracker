import { Module } from '@nestjs/common';
import { AuthorizationModule } from 'src/authorization/authorization.module';
import { PrismaModule } from 'src/prisma/prisma.module';
import { VolunteerTeamController } from './volunteer-team.controller';
import { VolunteerTeamService } from './volunteer-team.service';
import { VolunteerTypeController } from './volunteer-type.controller';
import { VolunteerTypeService } from './volunteer-type.service';
import { VolunteerController } from './volunteer.controller';
import { VolunteerService } from './volunteer.service';

@Module({
  imports: [PrismaModule, AuthorizationModule],
  providers: [VolunteerTypeService, VolunteerService, VolunteerTeamService],
  controllers: [VolunteerTypeController, VolunteerController, VolunteerTeamController],
})
export class VolunteerModule {}
