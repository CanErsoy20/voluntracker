import { VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';

export class CreateVolunteerTypeDto {
  typeName: VolunteerTypeEnum;
  category: VolunteerCategoryEnum;
}
