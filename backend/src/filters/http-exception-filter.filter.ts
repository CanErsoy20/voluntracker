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
    const message = exception instanceof HttpException ? exception.message : 'Internal server error';

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

    const finalResponse = process.env.NODE_ENV === 'DEV' ? devErrorResponse : prodErrorResponse;

    this.logger.error(
      `Request method: ${request.method}.\n Request url: ${request.url}.\n Error response: ${JSON.stringify(
        finalResponse,
        null,
        2,
      )}`,
    );

    response.status(status).json(finalResponse);
  }
}
