import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Injectable,
  Logger,
} from '@nestjs/common';
import 'dotenv/config';

@Injectable()
@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(HttpExceptionFilter.name);

  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const request = ctx.getRequest();
    const response = ctx.getResponse();

    const status =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;
    const message =
      exception instanceof HttpException
        ? exception.message
        : 'Internal server error';

    const devErrorResponse = {
      status,
      name: exception?.name,
      message: exception?.message,
      method: request.method,
      path: request.url,
      timestamp: new Date().toISOString(),
    };

    const prodErrorResponse = {
      status,
      message,
    };

    this.logger.log(
      `request method: ${request.method} request url${request.url}`,
      JSON.stringify(devErrorResponse),
    );

    response
      .status(status)
      .json(
        process.env.NODE_ENV === 'DEV' ? devErrorResponse : prodErrorResponse,
      );
  }
}
