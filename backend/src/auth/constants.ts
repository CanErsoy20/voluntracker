export const jwtConstants = {
  accessSecret: process.env.JWT_ACCESS_SECRET,
  refreshSecret: process.env.JWT_REFRESH_SECRET,
};

export const saltOrRounds = 10;

export const accessTokenExpiration = 15 * 60;

export const refreshTokenExpiration = 60 * 60;
