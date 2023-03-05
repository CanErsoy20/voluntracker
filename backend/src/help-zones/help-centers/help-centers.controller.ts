import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { ApiCreatedResponse, ApiTags } from '@nestjs/swagger';
import { CreateHelpCenterDto } from './dto/create-help-center.dto';
import { UpdateHelpCenterDto } from './dto/update-help-center.dto';
import { HelpCenterEntity } from './entities/help-center.entity';
import { HelpCentersService } from './help-centers.service';

@Controller('helpCenters')
@ApiTags('HelpCenters')
export class HelpCentersController {
  constructor(private readonly helpCentersService: HelpCentersService) {}

  @Post()
  @ApiCreatedResponse({ type: HelpCenterEntity })
  create(@Body() createHelpCenterDto: CreateHelpCenterDto) {
    return this.helpCentersService.create(createHelpCenterDto);
  }

  @Get()
  @ApiCreatedResponse({ type: HelpCenterEntity, isArray: true })
  findAll() {
    return this.helpCentersService.findAll();
  }

  @Get(':id')
  @ApiCreatedResponse({ type: HelpCenterEntity })
  findOne(@Param('id') id: string) {
    return this.helpCentersService.findOne(+id);
  }

  @Patch(':id')
  @ApiCreatedResponse({ type: HelpCenterEntity })
  update(
    @Param('id') id: string,
    @Body() updateHelpCenterDto: UpdateHelpCenterDto,
  ) {
    return this.helpCentersService.update(+id, updateHelpCenterDto);
  }

  @ApiCreatedResponse({ type: HelpCenterEntity })
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.helpCentersService.remove(+id);
  }
}
