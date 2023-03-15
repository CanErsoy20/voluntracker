import {
  Body,
  ConflictException,
  Controller,
  Get,
  InternalServerErrorException,
  Logger,
  Post,
  Request,
  UseGuards,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { CreateUserDto } from '../auth/dto/create-user.dto';
import { HttpResponse } from '../common';
import { GetCurrentUser, GetCurrentUserId } from '../common/decorators';
import { JwtRefreshAuthGuard, LocalAuthGuard } from '../common/guards';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { Tokens } from './types';

@ApiTags('Authentication')
@Controller('auth')
export class AuthController {
  private readonly logger = new Logger(AuthController.name);
  constructor(private readonly authService: AuthService) {}

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Body() createUserDto: CreateUserDto) {
    const tokens = await this.authService.signup(createUserDto);
    if (!tokens) {
      throw new InternalServerErrorException(
        'Something went wrong while we are trying to log you in. Please try again in a few moments.',
      );
    }

    return new HttpResponse(tokens, 'Login successful', 200);
  }

  @Post('signup')
  async signup(@Body() createUserDto: CreateUserDto): Promise<HttpResponse<Tokens>> {
    // Hash the password and register the user
    const tokens = await this.authService.signup(createUserDto);
    if (!tokens) {
      throw new InternalServerErrorException(
        'Something went wrong while we are trying to sign you up. Please try again in a few moments.',
      );
    }

    return new HttpResponse(tokens, 'Successfully registered the user', 201);
  }

  @Post('logout')
  async logout(@GetCurrentUserId() userId: number) {
    const isSuccessful = await this.authService.logout(userId);
    return new HttpResponse(null, 'Logout successful', 200);
  }

  @Post('refresh')
  @UseGuards(JwtRefreshAuthGuard)
  async refresh(@GetCurrentUserId() userId: number, @GetCurrentUser('refreshToken') refreshToken: string) {
    const tokens = await this.authService.refreshTokens(userId, refreshToken);
    return new HttpResponse(tokens, 'Refresh successful', 200);
  }
}
