import { Module } from '@nestjs/common';
import { NeededSupplyService } from './needed-supply.service';
import { NeededSupplyController } from './needed-supply.controller';

@Module({
  controllers: [NeededSupplyController],
  providers: [NeededSupplyService]
})
export class NeededSupplyModule {}
