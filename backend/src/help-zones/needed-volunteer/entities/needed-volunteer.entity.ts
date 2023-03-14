import { NeededVolunteer, UrgencyEnum, VolunteerCategoryEnum, VolunteerTypeEnum } from '@prisma/client';

export class NeededVolunteerEntity implements NeededVolunteer {
  id: number;
  quantity: number;
  urgency: UrgencyEnum;
  volunteerTypeName: VolunteerTypeEnum;
  volunteerTypeCategory: VolunteerCategoryEnum;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
