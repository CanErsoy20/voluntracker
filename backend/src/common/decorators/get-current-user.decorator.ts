import { createParamDecorator, ExecutionContext, Logger } from '@nestjs/common';
import { JwtPayloadWithRt } from '../../authentication/types';

export const GetCurrentUser = createParamDecorator(
  (data: keyof JwtPayloadWithRt | undefined, context: ExecutionContext) => {
    const logger = new Logger();
    const request = context.switchToHttp().getRequest();
    logger.log(request.user);
    if (!data) return request.user;
    return request.user[data];
  },
);
