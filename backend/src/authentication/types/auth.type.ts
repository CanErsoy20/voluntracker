import { User, UserRole, Volunteer } from '@prisma/client';

export type Tokens = {
  accessToken: string;
  refreshToken: string;
};

export type JwtPayload = {
  sub: number;
  email: string;
};

export type JwtPayloadWithRt = JwtPayload & { refreshToken: string };
