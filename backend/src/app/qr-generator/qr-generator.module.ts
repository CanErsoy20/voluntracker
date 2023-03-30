import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { QrGeneratorController } from './qr-generator.controller';
import { QrGeneratorService } from './qr-generator.service';

@Module({
  providers: [QrGeneratorService],
  controllers: [QrGeneratorController],
  imports: [PrismaModule],
  exports: [QrGeneratorService],
})
export class QrGeneratorModule {}
