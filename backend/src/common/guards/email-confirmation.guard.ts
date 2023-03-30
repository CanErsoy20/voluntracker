import { CanActivate, ExecutionContext, Injectable, Logger, UnauthorizedException } from '@nestjs/common';
import { UserEntity } from 'src/authentication/entities/user.entity';

@Injectable()
export class EmailConfirmationGuard implements CanActivate {
  canActivate(context: ExecutionContext) {
    const logger = new Logger();

    const request = context.switchToHttp().getRequest();
    const user = request.user as UserEntity;
    if (!user?.isEmailConfirmed) {
      throw new UnauthorizedException('Confirm your email first');
    }

    return true;
  }
}
