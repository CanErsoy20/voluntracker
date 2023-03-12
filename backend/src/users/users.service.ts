import { Injectable } from '@nestjs/common';
import { ApiResponseProperty } from '@nestjs/swagger';
import { User } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async create(createUserDto: CreateUserDto) {
    return await this.prisma.user.create({ data: createUserDto });
  }

  async findAll(): Promise<User[]> {
    return await this.prisma.user.findMany();
  }

  async findOne(id: number): Promise<User> {
    return await this.prisma.user.findUnique({ where: { id } });
  }

  async findOneByEmail(email: string): Promise<User> {
    return await this.prisma.user.findUnique({ where: { email } });
  }

  async findOneByPhone(phone: string): Promise<User> {
    return await this.prisma.user.findUnique({ where: { phone } });
  }

  async findOneByQuery(query: any[]): Promise<User> {
    return await this.prisma.user.findFirst({
      where: {
        OR: [...query],
      },
    });
  }

  async update(id: number, updateUserDto: UpdateUserDto): Promise<User> {
    return await this.prisma.user.update({ where: { id }, data: updateUserDto });
  }

  async remove(id: number): Promise<User> {
    return await this.prisma.user.delete({ where: { id } });
  }
}
