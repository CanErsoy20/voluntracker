import { Controller, Get } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { QrGeneratorService } from './qr-generator.service';

@ApiTags('QR-Generation')
@Controller('qrGenerator')
export class QrGeneratorController {
  constructor(private readonly qrGeneratorService: QrGeneratorService) {}

  @Get()
  async generate(text: string) {}
}
