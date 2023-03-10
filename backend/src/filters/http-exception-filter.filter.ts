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
      exception instanceof HttpException ? exception.getStatus() : HttpStatus.INTERNAL_SERVER_ERROR;
    let message: string[] = [];
    message.push(exception instanceof HttpException ? exception.message : 'Internal server error');

    const devErrorResponse = {
      error: {
        status,
        name: exception?.name,
        message: message,
        method: request.method,
        path: request.url,
        timestamp: new Date().toISOString(),
      },
    };
    const prodErrorResponse = {
      error: {
        status,
        message,
      },
    };

    const finalResponse = process.env.NODE_ENV === 'DEV' ? devErrorResponse : prodErrorResponse;

    this.logger.error(
      `Request method: ${request.method}.\n Request url: ${request.url}.\n Error response: ${JSON.stringify(
        finalResponse,
        null,
        2,
      )}`,
    );

  }
}
