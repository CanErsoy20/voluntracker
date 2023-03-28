import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { UniqueEntityAlreadyExistsException } from 'src/exceptions/unique-entity-already-exists-exception.exception';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateRoleDto } from './dto/create-role.dto';

@Injectable()
export class UserRolesService {
  constructor(private readonly prisma: PrismaService) {}

  async create(createRoleDto: CreateRoleDto) {
    const { roleName } = createRoleDto;

    const createdRole = await this.prisma.userRole.create({
      data: {
        roleName: createRoleDto.roleName,
      },
    });

    return createdRole;
  }

  async findAll() {
    const roles = await this.prisma.userRole.findMany();
    return roles;
  }

  async deleteRoleByName(roleName: string) {
    const role = await this.prisma.userRole.findUnique({
      where: {
        roleName,
      },
    });

    if (!role) {
      throw new UniqueEntityNotFoundException(
        'Role with given name could not be found. Therefore the deletion is unsuccessful',
      );
    }

    const deletedRole = await this.prisma.userRole.delete({
      where: {
        roleName,
      },
    });
    return deletedRole;
  }
}
