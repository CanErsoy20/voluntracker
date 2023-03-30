import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { HttpResponse } from 'src/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async findAll() {
    return new HttpResponse(await this.usersService.findAll(), 'Fetched all users', 200);
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

  @Delete(':userId')
  async deleteUser(@Param('userId') userId: string) {
    const user = await this.usersService.deleteAccount(+userId);
    return new HttpResponse(user, 'Successfully removed the account', 200);
  }
}
