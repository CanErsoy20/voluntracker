import {
  Body,
  ConflictException,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { hash } from 'bcrypt';
import { saltOrRounds } from 'src/auth/constants';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async findAll() {
    const users = await this.usersService.findAll();
    if (users.length === 0) {
      throw new NotFoundException('There are currently no users recorded in the database');
    }

    return users;
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const user = await this.usersService.findOne(+id);
    if (!user) {
      throw new NotFoundException(`User with id: ${id} does not exist.`);
    }

    return user;
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    const user = await this.usersService.update(+id, updateUserDto);
    if (!user) {
      throw new NotFoundException(`Couldn't update the user. User with id: ${id} does not exist.`);
    }

    return user;
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    const user = await this.usersService.remove(+id);
    if (!user) {
      throw new NotFoundException(`Couldn't remove the user. User with id: ${id} does not exist.`);
    }

    return user;
  }
}
