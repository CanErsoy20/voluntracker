import { Test, TestingModule } from '@nestjs/testing';
import { NeededSupplyController } from './needed-supply.controller';
import { NeededSupplyService } from './needed-supply.service';

describe('NeededSupplyController', () => {
  let controller: NeededSupplyController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [NeededSupplyController],
      providers: [NeededSupplyService],
    }).compile();

    controller = module.get<NeededSupplyController>(NeededSupplyController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
