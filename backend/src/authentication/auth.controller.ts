import {
  BadRequestException,
  Body,
  Controller,
  Get,
  InternalServerErrorException,
  Logger,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiInternalServerErrorResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { EmailConfirmationGuard } from 'src/common/guards/email-confirmation.guard';
import { UniqueEntityAlreadyExistsException } from 'src/exceptions/unique-entity-already-exists-exception.exception';
import { CreateUserDto } from '../authentication/dto/create-user.dto';
import { HttpResponse } from '../common';
import { GetCurrentUser, GetCurrentUserId } from '../common/decorators';
import { AccessTokenGuard, LocalAuthGuard, RefreshTokenGuard } from '../common/guards';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { CreateVolunteerDto } from './dto/create-volunteer.dto';
import { Tokens } from './types';
import { JwtTokensDto, LoginInformation } from './types/return.type';

@ApiTags('Authentication')
@Controller('auth')
export class AuthController {
  private readonly logger = new Logger(AuthController.name);
  constructor(private readonly authService: AuthService) {}

  @ApiOkResponse({
    description: 'Login is successful. A JWT Token is returned.',
    type: JwtTokensDto,
  })
  @ApiInternalServerErrorResponse({
    description: 'Something went wrong while generating JWT tokens.',
  })
  @UseGuards(AuthGuard('local'), LocalAuthGuard, EmailConfirmationGuard)
  @Post('login')
  async login(@Body() authDto: AuthDto): Promise<HttpResponse<LoginInformation>> {
    const tokens = await this.authService.login(authDto);
    if (!tokens) {
      throw new InternalServerErrorException(
        'Something went wrong while we are trying to log you in. Please try again in a few moments.',
      );
    }

    return new HttpResponse(tokens, 'Login successful', 200);
  }

  // @ApiOkResponse({
  //   description: 'Login is successful. A JWT Token is returned.',
  //   type: JwtTokensDto,
  // })
  // @ApiInternalServerErrorResponse({
  //   description: 'Something went wrong while generating JWT tokens.',
  // })
  // @Post('signup')
  // async signupUser(@Body() createUserDto: CreateUserDto): Promise<HttpResponse<Tokens>> {
  //   // Hash the password and register the user
  //   const tokens = await this.authService.signup(createUserDto);
  //   if (!tokens) {
  //     throw new InternalServerErrorException(
  //       'Something went wrong while we are trying to sign you up. Please try again in a few moments.',
  //     );
  //   }

  //   return new HttpResponse(tokens, 'Successfully registered the user', 201);
  // }

  @ApiOkResponse({
    description: 'Login is successful. A JWT Token is returned.',
    type: LoginInformation,
  })
  @ApiInternalServerErrorResponse({
    description: 'Something went wrong while generating JWT tokens.',
  })
  @Post('signup')
  async signupVolunteer(
    @Body('user') createUserDto: CreateUserDto,
    @Body('volunteer') createVolunteerDto: CreateVolunteerDto,
  ): Promise<HttpResponse<LoginInformation>> {
    const signedUpUser = await this.authService.signup(createUserDto, createVolunteerDto);

    if (!signedUpUser) {
      throw new BadRequestException('Something went wrong during registration');
    }

    return new HttpResponse(signedUpUser, 'Registration successfully completed', 201);
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
    type: JwtTokensDto,
  })
  @Post('refresh')
  @UseGuards(RefreshTokenGuard)
  async refresh(@GetCurrentUserId() userId: number, @GetCurrentUser('refreshToken') refreshToken: string) {
    const tokens = await this.authService.refreshTokens(userId, refreshToken);
    return new HttpResponse(tokens, 'Refresh successful', 200);
  }

  @Get('dummy')
  async dummy() {
    throw new UniqueEntityAlreadyExistsException('Why is this not working');
  }
}
