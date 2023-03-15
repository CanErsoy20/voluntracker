import { createParamDecorator, ExecutionContext, Logger } from '@nestjs/common';
import { JwtPayload } from '../../auth/types';

export const GetCurrentUserId = createParamDecorator((_: undefined, context: ExecutionContext): number => {
  const logger = new Logger();
  const request = context.switchToHttp().getRequest();
  logger.log(request.user);
  const user = request.user as JwtPayload;
  return user.sub;
});
