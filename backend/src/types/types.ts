export type OrderBy = 'asc' | 'desc';

export interface Response<T> {
  message: string;
  data: T;
  status?: number;
}
