import { VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';

export class VolunteerTypeDto {
  typeName: VolunteerTypeEnum;
  category: VolunteerCategoryEnum;
}
