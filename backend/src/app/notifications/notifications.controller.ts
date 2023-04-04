import { Body, Controller, Get, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { NotificationDto } from './dto/NotificationDto';
import { NotificationsService } from './notifications.service';
import { HttpResponse } from 'src/common';

@ApiTags('Notifications')
@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Post('send')
  async sendNotification(@Body() notificationDto: NotificationDto) {
    const notification = await this.notificationsService.sendNotification(notificationDto);
    return new HttpResponse(notification, 'Notification sent successfully', 200);
  }

  @Get()
  async getNotifications() {
    return await this.notificationsService.getNotifications();
  }
}
