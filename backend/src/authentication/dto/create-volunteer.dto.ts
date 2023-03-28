import { VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';

export class CreateVolunteerDto {
  volunteerTypeName: VolunteerTypeEnum;
  volunteerTypeCategory: VolunteerCategoryEnum;
}
