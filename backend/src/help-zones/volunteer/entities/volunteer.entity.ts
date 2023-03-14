import { Volunteer, VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';

export class VolunteerEntity implements Volunteer {
  id: number;
  userId: number;
  volunteerTypeName: VolunteerTypeEnum;
  volunteerTypeCategory: VolunteerCategoryEnum;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
