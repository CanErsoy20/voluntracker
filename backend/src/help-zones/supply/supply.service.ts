import { Injectable } from '@nestjs/common';
import { CreateSupplyDto } from './dto/create-supply.dto';
import { UpdateSupplyDto } from './dto/update-supply.dto';

@Injectable()
export class SupplyService {
  create(createSupplyDto: CreateSupplyDto) {
    return 'This action adds a new supply';
  }

  findAll() {
    return `This action returns all supply`;
  }

  findOne(id: number) {
    return `This action returns a #${id} supply`;
  }

  update(id: number, updateSupplyDto: UpdateSupplyDto) {
    return `This action updates a #${id} supply`;
  }

  remove(id: number) {
    return `This action removes a #${id} supply`;
  }
}
