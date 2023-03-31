import { BadRequestException, Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';
import { HttpResponse } from 'src/common';
import { UniqueEntityAlreadyExistsException } from 'src/exceptions/unique-entity-already-exists-exception.exception';
import { CreateRoleDto } from './dto/create-role.dto';
import { UserRolesService } from './user-roles.service';

@ApiTags('UserRoles')
@Controller('userRoles')
export class UserRolesController {
  constructor(private readonly userRolesService: UserRolesService) {}

  @Post()
  async createRole(@Body() createRoleDto: CreateRoleDto) {
    try {
      const role = await this.userRolesService.create(createRoleDto);

      return new HttpResponse(role, 'Successfully created a new role.', 201);
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new UniqueEntityAlreadyExistsException(
            'User role with given name already exists. Each role must have different names.',
          );
        }
      }
    }
  }

  @Get()
  async getRoles() {
    const roles = await this.userRolesService.findAll();
    return new HttpResponse(roles, 'Successfully fetched all roles.', 200);
  }

  @Delete(':roleName')
  async deleteRole(@Param('roleName') roleName: string) {
    const deletedRole = await this.userRolesService.deleteRoleByName(roleName);

    if (!deletedRole) {
      throw new BadRequestException('Something went wrong while trying to delete the user role.');
    }

    return new HttpResponse(deletedRole, 'Successfully deleted the role', 200);
  }
}
