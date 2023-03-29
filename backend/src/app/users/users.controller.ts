import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  findAll() {
    return this.usersService.findAll();
  }

  @Get(':email')
  findOneByEmail(@Param('email') email: string) {
    return this.usersService.findOneByEmail(email);
  }

  @Get(':phoneNumber')
  findOneByPhoneNumber(@Param('phoneNumber') phoneNumber: string) {
    return this.usersService.findOneByPhoneNumber(phoneNumber);
  }

  @Get(':id')
  findOneById(@Param('id') id: string) {
    return this.usersService.findOneById(+id);
  }
}
