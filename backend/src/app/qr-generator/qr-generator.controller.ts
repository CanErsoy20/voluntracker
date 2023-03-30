import { Body, Controller, Get, Param } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { QrGeneratorService } from './qr-generator.service';

@ApiTags('QR-Generation')
@Controller('qrGenerator')
export class QrGeneratorController {
  constructor(private readonly qrGeneratorService: QrGeneratorService) {}

  @Get(':/helpCenterId')
  async generate(@Body() data: string, @Param('helpCenterId') helpCenterId: string) {
    const uri = await this.qrGeneratorService.generateForHelpCenter(helpCenterId, +helpCenterId);
    return new HttpResponse(uri, 'Successfully generated QR code', 200);
  }
}
