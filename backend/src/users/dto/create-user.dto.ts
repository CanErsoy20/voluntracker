import { ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
  @ApiProperty({ required: true, nullable: false })
  firstname: string;

  @ApiProperty({ required: true, nullable: false })
  surname: string;

  @ApiProperty({ required: true, nullable: false })
  email: string;

  @ApiProperty({ required: true, nullable: false })
  password: string;

  @ApiProperty({ required: false })
  phone?: string;
}
