import { Test, TestingModule } from '@nestjs/testing';
import { NeededVolunteerService } from './needed-volunteer.service';

describe('NeededVolunteerService', () => {
  let service: NeededVolunteerService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [NeededVolunteerService],
    }).compile();

    service = module.get<NeededVolunteerService>(NeededVolunteerService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
