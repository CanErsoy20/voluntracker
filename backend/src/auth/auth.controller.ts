import {
  Body,
  ConflictException,
  Controller,
  Get,
  InternalServerErrorException,
  Logger,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiInternalServerErrorResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Request } from 'express';
import { CreateUserDto } from '../auth/dto/create-user.dto';
import { HttpResponse } from '../common';
import { GetCurrentUser, GetCurrentUserId } from '../common/decorators';
import { AccessTokenGuard, LocalAuthGuard, RefreshTokenGuard } from '../common/guards';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { Tokens } from './types';

@ApiTags('Authentication')
@Controller('auth')
export class AuthController {
  private readonly logger = new Logger(AuthController.name);
  constructor(private readonly authService: AuthService) {}

  @ApiOkResponse({
    description: 'Login is successful. A JWT Token is returned.',
  })
  @ApiInternalServerErrorResponse({
    description: 'Something went wrong while generating JWT tokens.',
  })
  @UseGuards(AuthGuard('local'), LocalAuthGuard)
  @Post('login')
  async login(@Body() authDto: AuthDto): Promise<HttpResponse<Tokens>> {
    const tokens = await this.authService.login(authDto);
    if (!tokens) {
      throw new InternalServerErrorException(
        'Something went wrong while we are trying to log you in. Please try again in a few moments.',
      );
    }

    return new HttpResponse(tokens, 'Login successful', 200);
  }

  @ApiOkResponse({
    description: 'Login is successful. A JWT Token is returned.',
  })
  @ApiInternalServerErrorResponse({
    description: 'Something went wrong while generating JWT tokens.',
  })
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

  @ApiOkResponse({
    description: 'Logout successful. Removes the refresh token stored in the DB.',
  })
  @Post('logout')
  @UseGuards(AccessTokenGuard)
  async logout(@GetCurrentUserId() id: number) {
    const isSuccessful = await this.authService.logout(id);
    return new HttpResponse(null, 'Logout successful', 200);
  }

  @ApiOkResponse({
    description:
      'Returns a new set of access and refresh tokens. Needs to be used when the access token is expired to get new access and refresh tokens.',
  })
  @Post('refresh')
  @UseGuards(RefreshTokenGuard)
  async refresh(@GetCurrentUserId() userId: number, @GetCurrentUser('refreshToken') refreshToken: string) {
    const tokens = await this.authService.refreshTokens(userId, refreshToken);
    return new HttpResponse(tokens, 'Refresh successful', 200);
  }
}
