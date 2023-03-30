import { Injectable } from '@nestjs/common';
import * as dotenv from 'dotenv';
import * as admin from 'firebase-admin';
import { PrismaService } from 'src/prisma/prisma.service';
import { NotificationDto } from './dto/NotificationDto';

@Injectable()
export class NotificationsService {
  constructor(private prisma: PrismaService) {
    dotenv.config();

    const serviceAccount = {
      projectId: process.env.FIREBASE_PROJECT_ID,
      privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
    };

    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      databaseURL: process.env.FIREBASE_DATABASE_URL,
    });
  }

  async sendNotification(notificationDto: NotificationDto) {
    const message = {
      notification: {
        title: notificationDto.title,
        body: notificationDto.body,
      },
      token: notificationDto.recipient,
    };

    try {
      const response = await admin.messaging().send(message);
      console.log('Successfully sent message:', response);
    } catch (error) {
      console.error('Error sending message:', error);
    }

    await this.prisma.notification.create({
      data: {
        title: notificationDto.title,
        body: notificationDto.body,
        recipient: notificationDto.recipient,
      },
    });
  }

  async getNotifications() {
    return await this.prisma.notification.findMany();
  }
}
