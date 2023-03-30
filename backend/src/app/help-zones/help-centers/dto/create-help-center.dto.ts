import { ApiProperty } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';
import { Type } from 'class-transformer';
import {
  IsDate,
  IsDateString,
  IsDefined,
  IsEmail,
  IsLatitude,
  IsLongitude,
  IsNumber,
  IsObject,
  IsOptional,
  IsPhoneNumber,
  IsString,
  Max,
  Min,
  ValidateNested,
} from 'class-validator';

class ContactInfo {
  @IsDefined()
  @IsPhoneNumber('TR')
  phone: string;

  @IsDefined()
  @IsString()
  address: string;

  @IsDefined()
  @IsEmail()
  email: string;
}

class StartEndDate {
  @IsDefined()
  @IsDateString()
  start: Date;

  @IsDefined()
  @IsDateString()
  end: Date;
}

class Location {
  @IsDefined()
  @IsLatitude()
  lat: number;

  @IsDefined()
  @IsLongitude()
  lon: number;
}

export class CreateHelpCenterDto {
  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Name or the title of the help center',
    example: 'Bilkent Üniversitesi Spor Salonu',
    minLength: 1,
    type: String,
  })
  @IsDefined()
  @IsString()
  name: string;

  @ApiProperty({
    required: true,
    nullable: false,
    description:
      'An object representing the location of the help center based on its latitude and longitude.',
    example: { lat: 39.9334, lon: 32.8597 },
    type: Object,
    properties: { lat: { type: 'Number' }, lon: { type: 'Number' } },
  })
  @IsDefined()
  @IsObject()
  @ValidateNested()
  @Type(() => Location)
  location: Location;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the start and end hours for the busiests hours in a help center.',
    example: {
      start: new Date().toISOString(),
      end: new Date().toISOString(),
    },
    type: Object,
    properties: { start: { type: 'String' }, end: { type: 'String' } },
  })
  @IsOptional()
  @IsObject()
  @ValidateNested()
  @Type(() => StartEndDate)
  busiestHours: StartEndDate;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the opening and closing hours of the help center.',
    example: {
      start: new Date().toISOString(),
      end: new Date().toISOString(),
    },
    type: Object,
    properties: { start: { type: 'String' }, end: { type: 'String' } },
  })
  @IsOptional()
  @IsObject()
  @ValidateNested()
  @Type(() => StartEndDate)
  openCloseInfo: StartEndDate;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Contains the opening and closing hours of the help center.',
    example: {
      phone: '+905392576103',
      address: 'Bilkent Üniversitesi 1598.Cadde 75.Yurt Kargo Merkezi',
      email: 'help.center@gmail.com',
    },
    type: Object,
    properties: { phone: { type: 'String' }, address: { type: 'String' }, email: { type: 'String' } },
  })
  @IsOptional()
  @IsObject()
  @ValidateNested()
  @Type(() => ContactInfo)
  contactInfo: ContactInfo;

  @ApiProperty({
    required: false,
    nullable: true,
    description: 'Represents the maximum number of volunteers this help center can have.',
    example: 250,
    type: Number,
  })
  @IsOptional()
  @IsNumber()
  @Min(1)
  @Max(10000)
  volunteerCapacity: number;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Represents the city this help center is located at.',
    example: 'Ankara',
    type: String,
  })
  @IsString()
  @IsDefined()
  city: string;

  @ApiProperty({
    required: true,
    nullable: false,
    description: 'Represents the country this help center is located at.',
    example: 'Ankara',
    type: String,
  })
  @IsString()
  @IsDefined()
  country: string;

  @ApiProperty({
    required: false,
    nullable: true,
    description:
      'Any additional info that is not already represented by other attributed. This might contain special information about the particular help center',
    example: 'The help center distributes food for the volunteers.',
    type: String,
  })
  @IsOptional()
  @IsString()
  additionalInfo: string;
}
