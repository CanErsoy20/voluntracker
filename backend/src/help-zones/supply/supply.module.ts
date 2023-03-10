import { Module } from '@nestjs/common';
import { SupplyEntity } from './entities/supply.entity';
import { SupplyController } from './supply.controller';
import { SupplyService } from './supply.service';

@Module({
  controllers: [SupplyController],
  providers: [SupplyService],
})
export class SupplyModule {}
