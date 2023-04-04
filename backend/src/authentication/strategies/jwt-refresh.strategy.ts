import { ForbiddenException, Injectable, Logger } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Request } from 'express';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { jwtConstants } from 'src/config';
@Injectable()
export class JwtRefreshStrategy extends PassportStrategy(Strategy, 'jwt-refresh') {
  private readonly logger: Logger = new Logger(JwtRefreshStrategy.name);
  constructor() {
    console.log("JWT CONSTANTS");
    console.log(jwtConstants);
    console.log(process.env.JWT_REFRESH_SECRET);
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_REFRESH_SECRET,
      passReqToCallback: true,
    });
  }

  async validate(req: Request, payload: any) {
    const refreshToken = req.get('authorization').replace('Bearer', '').trim();
    if (!refreshToken) {
      throw new ForbiddenException('Refresh token is invalid');
    }
    return { ...payload, refreshToken };
  }
}
