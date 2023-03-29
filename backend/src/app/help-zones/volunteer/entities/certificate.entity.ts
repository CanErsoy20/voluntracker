import { Certificate, Volunteer } from '@prisma/client';

export class CertificateEntity implements Certificate {
  id: number;
  name: string;
  certificateUrl: string;
  issuer: string;
  issueDate: Date;
  createdAt: Date;
  updatedAt: Date;
  volunteerId: number;
  volunteer: Volunteer;
}
