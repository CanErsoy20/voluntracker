import {
  BadRequestException,
  ConflictException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { compare as comparePassword } from 'bcrypt';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateUserDto } from 'src/users/dto/create-user.dto';
import { UserEntity } from 'src/users/entities/user.entity';
import { UsersService } from 'src/users/users.service';
import * as authConstants from '../config';
import { AuthDto } from './dto/auth.dto';
import { Tokens } from './types';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private jwtService: JwtService,
    private readonly prisma: PrismaService,
  ) {}

  async validateUser(email: string, password: string) {
    const user = await this.usersService.findOneByEmail(email);
    if (!user) {
      throw new UnauthorizedException(`There is something wrong with the user credentials.`);
    }

    const isPasswordValid = await comparePassword(password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException(`There is something wrong with the user credentials.`);
    }

    const { ...result } = user;
    return result;
  }

  async login(auth: AuthDto) {
    const payload = { email: auth.email, sub: auth.email };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }

  async signup(createUserDto: CreateUserDto): Promise<Tokens> {
    const { password } = createUserDto;
    const hashedPassword = await this.hash(password);
    const newUser = await this.usersService.create({ ...createUserDto, password: hashedPassword });

    if (!newUser) {
      throw new BadRequestException('Something went wrong...');
    }

    const tokens = await this.getTokens(newUser.id, newUser.email);
    return tokens;
  }

  async updateRefreshToken(userId: number, refreshToken: string) {
    const hash = await this.hash(refreshToken);
    await this.prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        hashedRefreshToken: hash,
      },
    });
  }

  hash(data: string) {
    return bcrypt.hash(data, authConstants.saltOrRounds);
  }

  async getTokens(userId: number, email: string) {
    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(
        {
          sub: userId,
          email,
        },
        {
          secret: authConstants.jwtConstants.accessSecret,
          expiresIn: authConstants.accessTokenExpiration,
        },
      ),
      this.jwtService.signAsync(
        {
          sub: userId,
          email,
        },
        {
          secret: authConstants.jwtConstants.refreshSecret,
          expiresIn: authConstants.refreshTokenExpiration,
        },
      ),
    ]);

    return {
      accessToken,
      refreshToken,
    };
  }
}
