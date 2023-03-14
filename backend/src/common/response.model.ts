import { Response } from 'src/types';

export class HttpResponse<T> implements Response<T> {
  status: number;
  message: string;
  data: T;

  constructor(data: T, message?: string, status?: number) {
    this.data = data;
    this.message = message;
    this.status = status;
  }
}
