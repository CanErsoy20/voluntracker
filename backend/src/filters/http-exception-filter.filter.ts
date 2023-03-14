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
import { Request, Response } from 'express';

type ErrorResponse = {
  statusCode: number;
  message: string | string[];
  error: string;
};

@Injectable()
@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(HttpExceptionFilter.name);

  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const request = ctx.getRequest<Request>();
    const response = ctx.getResponse<Response>();

    const status = exception.getStatus();
    const message: string[] = [];
    const errorResponse = exception.getResponse() as unknown as ErrorResponse;
    if (typeof errorResponse === 'object') {
      if (Array.isArray(errorResponse.message)) {
        message.push(...errorResponse.message);
      } else if (typeof errorResponse.message === 'string') {
        message.push(errorResponse.message);
      } else {
        message.push('Internal Server Error');
      }
    }

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
      `\nRequest method: ${request.method}.\n Request url: ${request.url}.\n Error response: ${JSON.stringify(
        finalResponse,
        null,
        2,
      )}`,
    );

    response.status(status).json(finalResponse);
  }
}
