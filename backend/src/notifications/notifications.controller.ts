import { Body, Controller, Get, Post } from '@nestjs/common';
import { NotificationsService } from './notifications.service';

@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Post()
  async sendNotification(
    @Body('title') title: string,
    @Body('body') body: string,
    @Body('recipient') recipient: string,
  ) {
    await this.notificationsService.sendNotification(title, body, recipient);
  }

  @Get()
  async getNotifications() {
    return await this.notificationsService.getNotifications();
  }
}