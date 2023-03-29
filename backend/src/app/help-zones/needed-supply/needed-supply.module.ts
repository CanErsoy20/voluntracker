import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { NeededSupplyEntity } from './entities/needed-supply.entity';
import { NeededSupplyController } from './needed-supply.controller';
import { NeededSupplyService } from './needed-supply.service';

@Module({
  controllers: [NeededSupplyController],
  providers: [NeededSupplyService],
  imports: [PrismaModule],
})
export class NeededSupplyModule {}
