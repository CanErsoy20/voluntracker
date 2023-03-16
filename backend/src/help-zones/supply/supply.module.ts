import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { SupplyTypeController } from './supply-type.controller';
import { SupplyTypeService } from './supply-type.service';

@Module({
  controllers: [SupplyTypeController],
  providers: [SupplyTypeService],
  imports: [PrismaModule],
})
export class SupplyModule {}
