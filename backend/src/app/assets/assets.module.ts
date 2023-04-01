import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { AssetsController } from './assets.controller';
import { AssetsService } from './assets.service';

@Module({
  providers: [AssetsService],
  controllers: [AssetsController],
  imports: [PrismaModule],
})
export class AssetsModule {}
