import { Test, TestingModule } from '@nestjs/testing';
import { NeededVolunteerController } from './needed-volunteer.controller';
import { NeededVolunteerService } from './needed-volunteer.service';

describe('NeededVolunteerController', () => {
  let controller: NeededVolunteerController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [NeededVolunteerController],
      providers: [NeededVolunteerService],
    }).compile();

    controller = module.get<NeededVolunteerController>(NeededVolunteerController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
