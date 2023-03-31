import { Injectable } from '@nestjs/common';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    const users = await this.prisma.user.findMany({
      include: {
        admin: true,
        userRole: true,
        volunteer: true,
      },
    });
    return users;
  }

  async findOneById(id: number) {
    const user = await this.prisma.user.findUnique({
      where: {
        id,
      },
      include: {
        volunteer: true,
        admin: true,
        userRole: true,
      },
    });
    if (!user) {
      throw new UniqueEntityNotFoundException('User with given id cannot be found');
    }

    return user;
  }

  async findOneByEmail(email: string) {
    const user = await this.prisma.user.findUnique({
      where: {
        email,
      },
      include: {
        volunteer: true,
      },
    });
    if (!user) {
      throw new UniqueEntityNotFoundException('User with given email cannot be found');
    }

    return user;
  }

  async findOneByPhoneNumber(phoneNumber: string) {
    const user = await this.prisma.user.findUnique({
      where: {
        phone: phoneNumber,
      },
      include: {
        volunteer: true,
      },
    });
    if (!user) {
      throw new UniqueEntityNotFoundException('User with given id cannot be found');
    }

    return user;
  }

  async confirmAccount(email: string) {
    const user = await this.prisma.user.update({
      where: {
        email,
      },
      data: {
        isEmailConfirmed: true,
        activationCode: '',
      },
    });
    return user;
  }

  async deleteAccount(userId: number) {
    const user = await this.prisma.user.delete({
      where: {
        id: userId,
      },
    });
    return user;
  }

  async assignConfirmationCode(email: string, code: string) {
    const user = await this.prisma.user.update({
      where: {
        email,
      },
      data: {
        activationCode: code || '',
      },
    });
  }
}
