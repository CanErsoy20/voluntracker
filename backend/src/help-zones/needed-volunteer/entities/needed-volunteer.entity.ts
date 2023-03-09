import { NeededVolunteer } from '@prisma/client';

export class NeededVolunteerEntity implements NeededVolunteer {
  id: number;
  quantity: number;
  urgency: number;
  volunteerTypeName: string;
  volunteerTypeCategory: string;
  helpCenterId: number;
  createdAt: Date;
  updatedAt: Date;
}
