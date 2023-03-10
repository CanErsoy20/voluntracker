import { Volunteer } from '@prisma/client';

export class VolunteerEntity implements Volunteer {
  id: number;
  userId: number;
  volunteerTypeName: string;
  volunteerTypeCategory: string;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
