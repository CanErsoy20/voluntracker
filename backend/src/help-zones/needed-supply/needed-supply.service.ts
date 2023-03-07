import { Injectable } from '@nestjs/common';
import { CreateNeededSupplyDto } from './dto/create-needed-supply.dto';
import { UpdateNeededSupplyDto } from './dto/update-needed-supply.dto';

@Injectable()
export class NeededSupplyService {
  create(createNeededSupplyDto: CreateNeededSupplyDto) {
    return 'This action adds a new neededSupply';
  }

  findAll() {
    return `This action returns all neededSupply`;
  }

  findOne(id: number) {
    return `This action returns a #${id} neededSupply`;
  }

  update(id: number, updateNeededSupplyDto: UpdateNeededSupplyDto) {
    return `This action updates a #${id} neededSupply`;
  }

  remove(id: number) {
    return `This action removes a #${id} neededSupply`;
  }
}
