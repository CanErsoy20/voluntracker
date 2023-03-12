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
import { CreateUserDto } from 'src/users/dto/create-user.dto';
import { UsersService } from 'src/users/users.service';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { LocalAuthGuard } from './guards/local.guard';
import { Tokens } from './types';

@ApiTags('Authentication')
@Controller('auth')
export class AuthController {
  private readonly logger = new Logger(AuthController.name);
  constructor(private readonly authService: AuthService) {}

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Body() authDto: AuthDto) {
    return this.authService.login(authDto);
  }

  @Post('signup')
  async signup(@Body() createUserDto: CreateUserDto): Promise<Tokens> {
    // Hash the password and register the user
    const tokens = this.authService.signup(createUserDto);
    if (!tokens) {
      throw new InternalServerErrorException(
        'Something went wrong while we are trying to sign you up. Please try again in a few moments.',
      );
    }

    return tokens;
  }

  @Post('logout')
  async logout(@Body() authDto: AuthDto) {}

  @Get('refresh')
  async refresh(@Request() req) {}
}
