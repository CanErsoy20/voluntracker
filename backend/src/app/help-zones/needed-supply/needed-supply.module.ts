import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { NeededSupplyEntity } from './entities/needed-supply.entity';
import { NeededSupplyTypeController } from './needed-supply-type.controller';
import { NeededSupplyTypeService } from './needed-supply-type.service';
import { NeededSupplyController } from './needed-supply.controller';
import { NeededSupplyService } from './needed-supply.service';

@Module({
  controllers: [NeededSupplyController, NeededSupplyTypeController],
  providers: [NeededSupplyService, NeededSupplyTypeService],
  imports: [PrismaModule],
})
export class NeededSupplyModule {}
