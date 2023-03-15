import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Prisma } from '@prisma/client';
import * as argon from 'argon2';
import { compare as comparePassword } from 'bcrypt';
import { CreateUserDto } from 'src/auth/dto/create-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import * as authConstants from '../config';
import { AuthDto } from './dto/auth.dto';
import { JwtPayload, Tokens } from './types';

@Injectable()
export class AuthService {
  constructor(private jwtService: JwtService, private readonly prisma: PrismaService) {}

  async validateUser(email: string, password: string) {
    const user = await this.prisma.user.findUnique({
      where: { email },
    });
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

  async login(authDto: AuthDto) {
    const { email, password } = authDto;
    const user = await this.prisma.user.findUnique({
      where: {
        email,
      },
    });

    if (!user) {
      throw new ForbiddenException('Login credentials are wrong');
    }

    const passwordMatches = await argon.verify(user.password, password);
    if (!passwordMatches) {
      throw new ForbiddenException('Login credentials are wrong');
    }

    const tokens = await this.getTokens(user.id, user.email);
    await this.updateRefreshToken(user.id, tokens.refreshToken);

    return tokens;
  }

  async logout(userId: number) {
    await this.prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        hashedRefreshToken: null,
      },
    });
    return true;
  }

  async signup(createUserDto: CreateUserDto): Promise<Tokens> {
    const { password } = createUserDto;
    const hashedPassword = await this.hash(password);

    try {
      const newUser = await this.prisma.user.create({ data: { ...createUserDto, password: hashedPassword } });

      if (!newUser) {
        throw new BadRequestException('Something went wrong...');
      }

      const tokens = await this.getTokens(newUser.id, newUser.email);
      await this.updateRefreshToken(newUser.id, tokens.refreshToken);
      return tokens;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new ConflictException('Signup failed because this email is already being used.');
        }
      }
    }
  }

  async refreshTokens(userId: number, rt: string): Promise<Tokens> {
    const user = await this.prisma.user.findUnique({
      where: {
        id: userId,
      },
    });
    if (!user || !user.hashedRefreshToken) {
      throw new ForbiddenException('Access Denied');
    }

    const rtMatches = await argon.verify(user.hashedRefreshToken, rt);
    if (!rtMatches) {
      throw new ForbiddenException('Access Denied');
    }

    const tokens = await this.getTokens(user.id, user.email);
    await this.updateRefreshToken(user.id, tokens.refreshToken);
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

  async getTokens(userId: number, email: string): Promise<Tokens> {
    const jwtPayload: JwtPayload = {
      sub: userId,
      email,
    };

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(jwtPayload, {
        secret: authConstants.jwtConstants.accessSecret,
        expiresIn: authConstants.accessTokenExpiration,
      }),
      this.jwtService.signAsync(jwtPayload, {
        secret: authConstants.jwtConstants.refreshSecret,
        expiresIn: authConstants.refreshTokenExpiration,
      }),
    ]);

    return {
      accessToken,
      refreshToken,
    };
  }

  async hash(data: string) {
    return await argon.hash(data);
  }
}
