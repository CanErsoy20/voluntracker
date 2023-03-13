export type DateInterval = {
  start: Date;
  end: Date;
};

export type Geolocation = {
  lat: number;
  lon: number;
};

export type ContactInfo = {
  phone: string;
  addres: string;
  email: string;
};

export type OrderBy = 'asc' | 'desc';

export enum UrgencyEnum {
  Low = 0,
  Medium = 1,
  High = 2,
}
