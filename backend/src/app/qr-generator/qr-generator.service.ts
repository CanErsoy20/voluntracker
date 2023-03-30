import { Injectable, Logger } from '@nestjs/common';
import { create } from 'domain';
import { QR_EXPIRATION_TIME_IN_MS } from 'src/config';
import { QrCodeExpiredException } from 'src/exceptions/qr-code-expired.exception';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { v4 as uuid } from 'uuid';
const QRCode = require('qrcode');

@Injectable()
export class QrGeneratorService {
  constructor(private readonly prisma: PrismaService) {}
  private logger: Logger = new Logger();

  async generateForHelpCenter(data: string, helpCenterId: number) {
    const qrUuid = uuid();
    const qrURI = await this.generate(data);

    await this.prisma.qrCode.create({
      data: {
        uuid: qrUuid,
        helpCenter: {
          connect: {
            id: helpCenterId,
          },
        },
      },
    });

    return { qrURI, qrUuid };
  }

  async generate(data: string) {
    const creationTime = new Date().getTime();
    const qrURI = await QRCode.toDataURL(`${data}|${creationTime}`);
    return qrURI;
  }

  async checkExpiry(uuid: string) {
    const qr = await this.prisma.qrCode.findUnique({
      where: {
        uuid,
      },
    });
    if (!qr) {
      throw new UniqueEntityNotFoundException('QR code does not exist in the database.');
    }

    const createdAt = qr.createdAt;
    if (createdAt.getTime() + QR_EXPIRATION_TIME_IN_MS < new Date().getTime()) {
      throw new QrCodeExpiredException('The QR code has expired. Try using a new QR code.');
    }

    return false;
  }
}
