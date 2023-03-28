import { Body, Controller, Get, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { NotificationDto } from './dto/NotificationDto';
import { NotificationsService } from './notifications.service';

@ApiTags('Notifications')
@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Post('send')
  async sendNotification(@Body() notificationDto: NotificationDto) {
    await this.notificationsService.sendNotification(notificationDto);
  }

  @Get()
  async getNotifications() {
    return await this.notificationsService.getNotifications();
  }
}
