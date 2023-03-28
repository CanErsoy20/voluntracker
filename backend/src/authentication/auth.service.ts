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
import { CreateUserDto } from 'src/authentication/dto/create-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import * as authConstants from '../config';
import { AuthDto } from './dto/auth.dto';
import { CreateVolunteerDto } from './dto/create-volunteer.dto';
import { JwtPayload, Tokens } from './types';

@Injectable()
export class AuthService {
  constructor(private jwtService: JwtService, private readonly prisma: PrismaService) {}

  async validateUser(email: string, password: string) {
    const user = await this.prisma.user.findUnique({
      where: { email },
    });
    if (!user) {
      throw new ForbiddenException(`There is something wrong with logincredentials.`);
    }

    const isPasswordValid = await argon.verify(user.password, password);
    if (!isPasswordValid) {
      throw new ForbiddenException(`There is something wrong with login credentials.`);
    }

    const { ...result } = user;
    return result;
  }

  async login(authDto: AuthDto) {
    const { email } = authDto;
    const user = await this.prisma.user.findUnique({
      where: { email },
    });

    const tokens = await this.getTokens(user.id, user.email);
    await this.updateRefreshToken(user.id, tokens.refreshToken);

    return tokens;
  }

  async logout(userId: number) {
    await this.prisma.user.updateMany({
      where: {
        id: userId,
        hashedRefreshToken: {
          not: null,
        },
      },
      data: {
        hashedRefreshToken: null,
      },
    });
    return true;
  }

  async signup(createUserDto: CreateUserDto, createVolunteerDto: CreateVolunteerDto) {
    const { password } = createUserDto;
    const hashedPassword = await this.hash(password);

    try {
      const newUser = await this.prisma.user.create({
        data: {
          ...createUserDto,
          password: hashedPassword,
          userRole: {
            connectOrCreate: {
              create: {
                roleName: 'Volunteer',
              },
              where: {
                roleName: 'Volunteer',
              },
            },
          },
          volunteer: {
            create: {
              ...createVolunteerDto,
            },
          },
        },
        include: {
          userRole: true,
          volunteer: true,
        },
      });

      if (!newUser) {
        throw new BadRequestException('Something went wrong...');
      }

      const tokens = await this.getTokens(newUser.id, newUser.email);
      await this.updateRefreshToken(newUser.id, tokens.refreshToken);

      return { tokens, user: newUser };
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
      throw new ForbiddenException('Access denied.');
    }

    const rtMatches = await argon.verify(user.hashedRefreshToken, rt);
    if (!rtMatches) {
      throw new ForbiddenException('Access denied.');
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
