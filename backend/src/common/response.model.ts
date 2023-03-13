import { Response } from 'src/types';

class HttpResponse<T> implements Response<T> {
  status: number;
  message: string;
  data: T;
}
