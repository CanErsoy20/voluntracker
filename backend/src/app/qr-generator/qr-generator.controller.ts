import { Body, Controller, Get, Param } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { QRCodeEntity } from './entity/QRCode.entity';
import { QrGeneratorService } from './qr-generator.service';

@ApiTags('QR-Generation')
@Controller('qrGenerator')
export class QrGeneratorController {
  constructor(private readonly qrGeneratorService: QrGeneratorService) {}

  @ApiOkResponse({
    type: QRCodeEntity,
    description: 'Returns a QR URI and the UUID for it.',
  })
  @Get(':/helpCenterId')
  async generate(@Body() data: string, @Param('helpCenterId') helpCenterId: string) {
    const uri = (await this.qrGeneratorService.generateForHelpCenter(
      helpCenterId,
      +helpCenterId,
    )) as QRCodeEntity;
    return new HttpResponse(uri, 'Successfully generated QR code', 200);
  }
}
