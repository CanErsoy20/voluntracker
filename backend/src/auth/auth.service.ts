import { ConflictException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from 'src/users/dto/create-user.dto';
import { UserEntity } from 'src/users/entities/user.entity';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class AuthService {
  constructor(private readonly usersService: UsersService, private jwtService: JwtService) {}

  async validateUser(email: string, password: string) {
    const user = await this.usersService.findOneByEmail(email);
    if (user && user.password === password) {
      const { password, ...result } = user;
      return result;
    }

    return null;
  }

  async login(user: UserEntity) {
    const payload = { email: user.email, sub: user.id };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }

  async register(createUserDto: CreateUserDto) {
    const { email, phone } = createUserDto;

    let user = await this.usersService.findOneByEmail(email);
    if (user) {
      throw new ConflictException('User with the given email already exists');
    }

    user = await this.usersService.findOneByPhone(phone);
    if (user) {
      throw new ConflictException('User with the given phone number already exists');
    }

    return this.usersService.create(createUserDto);
  }
}
