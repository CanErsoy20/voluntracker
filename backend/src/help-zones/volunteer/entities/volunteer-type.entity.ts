import { VolunteerCategoryEnum, VolunteerType, VolunteerTypeEnum } from '@prisma/client';

export class VolunteerTypeEntity implements VolunteerType {
  typeName: VolunteerTypeEnum;
  category: VolunteerCategoryEnum;
  createdAt: Date;
  updatedAt: Date;
}
