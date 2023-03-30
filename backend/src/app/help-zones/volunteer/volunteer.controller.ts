import { BadRequestException, Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { HttpResponse } from 'src/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateCertificateDto } from './dto/create-certificate.dto';
import { UpdateCertificateDto } from './dto/update-certificate.dto';
import { VolunteerService } from './volunteer.service';

@Controller('volunteers')
export class VolunteerController {
  constructor(private readonly volunteerService: VolunteerService) {}
  @Get(':id')
  async find(@Param('id') id: string) {
    const volunteer = await this.volunteerService.getVolunteer(+id);

    return new HttpResponse(volunteer, 'Successfully fetched the details for the volunteer', 200);
  }

  @Post('/:id/certificates')
  async createCertificate(
    @Param('id') volunteerId: string,
    @Body() createCertificateDto: CreateCertificateDto,
  ) {
    const volunteerWithCertificate = await this.volunteerService.addCertificate(
      +volunteerId,
      createCertificateDto,
    );
    if (!volunteerWithCertificate) {
      throw new BadRequestException('Something bad happened while creating a certificate.');
    }

    return new HttpResponse(volunteerWithCertificate, 'Successfully created the certificate', 200);
  }

  @Patch('certificates/:id')
  async updateCertificate(
    @Param('id') certificateId: string,
    @Body() updateCertificateDto: UpdateCertificateDto,
  ) {
    const certificate = await this.volunteerService.updateCertificate(+certificateId, updateCertificateDto);

    if (!certificate) {
      throw new BadRequestException('Something bad happened while creating a certificate.');
    }

    return new HttpResponse(certificate, 'Successfully updated certificate details.', 200);
  }

  @Delete('certificates/:id')
  async deleteCertificate(@Param('id') certificateId) {
    const certificate = await this.volunteerService.deleteCertificate(+certificateId);

    if (!certificate) {
      throw new BadRequestException('Something bad happened while creating a certificate.');
    }

    return new HttpResponse(certificate, 'Successfully deleted the certificate', 200);
  }

  @Patch('helpCenters/:helpCenterId')
  async followHelpCenter(@Param('helpCenterId') helpCenterId: number) {}
}
