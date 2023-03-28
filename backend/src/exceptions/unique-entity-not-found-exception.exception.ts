import { HttpException, HttpStatus } from '@nestjs/common';

export class UniqueEntityNotFoundException extends HttpException {
  constructor(message: string) {
    super({ message }, HttpStatus.NOT_FOUND);
  }
}
