import { ApiProperty } from '@nestjs/swagger';
import { User, UserRole, Volunteer } from '@prisma/client';

export class UserEntity implements User {
  @ApiProperty({ required: true, nullable: false })
  id: number;

  @ApiProperty({ required: true, nullable: false })
  firstname: string;

  @ApiProperty({ required: true, nullable: false })
  surname: string;

  @ApiProperty({ required: true, nullable: false })
  email: string;

  @ApiProperty({ required: true, nullable: false })
  password: string;

  @ApiProperty({ required: false, nullable: true })
  phone: string | null;

  @ApiProperty({ required: false, nullable: false })
  roleId: number;

  @ApiProperty({ required: false, nullable: true })
  userRole: UserRole | null;

  @ApiProperty({ required: false, nullable: true })
  volunteer: Volunteer | null;

  @ApiProperty({ required: false, nullable: true })
  hashedRefreshToken: string;

  @ApiProperty({ required: true, nullable: false })
  createdAt: Date;

  @ApiProperty({ required: true, nullable: false })
  @ApiProperty()
  updatedAt: Date;
}
