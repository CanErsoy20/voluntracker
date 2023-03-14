import { CallHandler, ExecutionContext, Injectable, Logger, NestInterceptor } from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Response } from 'src/types';

@Injectable()
export class TransformInterceptor<T> implements NestInterceptor<T, Response<T>> {
  private readonly logger = new Logger(TransformInterceptor.name);

  intercept(context: ExecutionContext, next: CallHandler): Observable<Response<T>> {
    return next.handle().pipe(
      map((response: Response<T>) => {
        this.logger.log(
          `Intercepting the HttpResponse:\nMessage: ${response.message}\nStatus: ${response.status}`,
        );

        return {
          status: response?.status ? response.status : context.switchToHttp().getResponse().statusCode || 400, // Overrides default status code
          message: response.message,
          data: response.data,
        };
      }),
    );
  }
}
