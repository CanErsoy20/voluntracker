import { Module } from '@nestjs/common';
import { QrGeneratorModule } from 'src/app/qr-generator/qr-generator.module';
import { UsersModule } from 'src/app/users/users.module';
import { AuthorizationModule } from 'src/authorization/authorization.module';
import { PrismaModule } from 'src/prisma/prisma.module';
import { NeededSupplyService } from '../needed-supply/needed-supply.service';
import { NeededVolunteerService } from '../needed-volunteer/needed-volunteer.service';
import { VolunteerTeamService } from '../volunteer/volunteer-team.service';
import { VolunteerModule } from '../volunteer/volunteer.module';
import { VolunteerService } from '../volunteer/volunteer.service';
import { HelpCentersController } from './help-centers.controller';
import { HelpCentersService } from './help-centers.service';

@Module({
  controllers: [HelpCentersController],
  providers: [
    HelpCentersService,
    NeededVolunteerService,
    NeededSupplyService,
    VolunteerService,
    VolunteerTeamService,
  ],
  imports: [PrismaModule, QrGeneratorModule, VolunteerModule, AuthorizationModule, UsersModule],
})
export class HelpCentersModule {}
