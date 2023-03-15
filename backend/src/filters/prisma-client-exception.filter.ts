import { ArgumentsHost, Catch, HttpStatus, Logger } from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import { Prisma } from '@prisma/client';
import { error } from 'console';
import { Request, Response } from 'express';

@Catch(Prisma.PrismaClientKnownRequestError)
export class PrismaClientExceptionFilter extends BaseExceptionFilter {
  private readonly logger = new Logger(PrismaClientExceptionFilter.name);

  catch(exception: Prisma.PrismaClientKnownRequestError, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const request = ctx.getRequest<Request>();
    const response = ctx.getResponse<Response>();
    const message = exception.message.replace(/\n/g, '');

    const errorResponse = {
      status: response.status,
      name: 'Prisma DB Exception',
      message,
      method: request.method,
      path: request.url,
      timestamp: new Date().toISOString(),
    };

    this.logger.error(
      `Request method: ${request.method}.\n Request url: ${request.url}.\n Error response: ${JSON.stringify(
        errorResponse,
        null,
        2,
      )}`,
    );

    switch (exception.code) {
      case 'P2002':
        response.json({
          ...errorResponse,
          message: `There is a unique constraint validation, the process couldn't be completed because of ${exception.meta.target}`,
        });
        break;

      default:
        break;
    }
  }
}
