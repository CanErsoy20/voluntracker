import { Module } from '@nestjs/common';
import { NeededSupplyEntity } from './entities/needed-supply.entity';
import { NeededSupplyController } from './needed-supply.controller';
import { NeededSupplyService } from './needed-supply.service';

@Module({
  controllers: [NeededSupplyController],
  providers: [NeededSupplyService],
})
export class NeededSupplyModule {}
