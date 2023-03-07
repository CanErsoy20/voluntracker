import { Test, TestingModule } from '@nestjs/testing';
import { NeededSupplyService } from './needed-supply.service';

describe('NeededSupplyService', () => {
  let service: NeededSupplyService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [NeededSupplyService],
    }).compile();

    service = module.get<NeededSupplyService>(NeededSupplyService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
