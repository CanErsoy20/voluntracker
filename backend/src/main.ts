import { BadRequestException, ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { DocumentBuilder } from '@nestjs/swagger';
import { SwaggerModule } from '@nestjs/swagger/dist';
import { ValidationError } from 'class-validator';
import helmet from 'helmet';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './filters/http-exception-filter.filter';
import { PrismaClientExceptionFilter } from './filters/prisma-client-exception.filter';
import { TransformInterceptor } from './interceptors/transform.interceptor';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.use(helmet());

  // Global prefix
  app.setGlobalPrefix('api/v1');

  // ValidationPipeline setup
  // {
  //   exceptionFactory: (errors: ValidationError[] = []) => {
  //     return new BadRequestException(errors);
  //   },
  //   validationError: {
  //     target: false,
  //     value: true,
  //   },
  // }),
  app.useGlobalPipes(new ValidationPipe());
  app.useGlobalFilters(new HttpExceptionFilter());
  app.useGlobalFilters(new PrismaClientExceptionFilter());
  app.useGlobalInterceptors(new TransformInterceptor());

  // Swagger setup
  const config = new DocumentBuilder()
    .setTitle('afet-takip API Documentation')
    .setDescription('afet-takip API')
    .setVersion('0.1')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  // Listen at port 3000
  await app.listen(process.env.PORT || 3000);
}
bootstrap();
