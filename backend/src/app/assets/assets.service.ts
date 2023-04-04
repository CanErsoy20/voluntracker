import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { UniqueEntityNotFoundException } from 'src/exceptions/unique-entity-not-found-exception.exception';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserImageDto } from './dto/user-image.dto';

@Injectable()
export class AssetsService {
  constructor(private readonly prisma: PrismaService) {}

  async getHelpCenterImages(helpCenterId: number) {
    try {
      const helpCenter = await this.prisma.helpCenter.findUnique({
        where: {
          id: helpCenterId,
        },
      });
      return helpCenter.helpCenterImageUrls;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Help center you are trying to update cannot be found in the system.',
          );
        }
      }
      throw e;
    }
  }

  async updateHelpCenterImages(helpCenterId: number, oldUrl: string, newUrl: string) {
    try {
      const helpCenter = await this.prisma.helpCenter.findUnique({
        where: {
          id: helpCenterId,
        },
      });

      // Update the array of images
      const imageUrls = helpCenter.helpCenterImageUrls;
      const indexOfOldUrl = imageUrls.indexOf(oldUrl);
      if (indexOfOldUrl < 0) {
        throw new UniqueEntityNotFoundException(`The image that is being tried to be deleted with given URL 
            does not exist in the database.`);
      }
      imageUrls[indexOfOldUrl] = newUrl;
      const updatedHelpCenter = await this.prisma.helpCenter.update({
        where: {
          id: helpCenterId,
        },
        data: {
          helpCenterImageUrls: {
            set: imageUrls,
          },
        },
      });
      return updatedHelpCenter.helpCenterImageUrls;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Help center you are trying to update cannot be found in the system.',
          );
        }
      }
      throw e;
    }
  }

  async deleteHelpCenterImage(helpCenterId: number, imageUrl: string) {
    try {
      const helpCenter = await this.prisma.helpCenter.findUnique({
        where: {
          id: helpCenterId,
        },
      });

      // Update the array of images
      const imageUrls = helpCenter.helpCenterImageUrls;
      const indexOfUrl = imageUrls.indexOf(imageUrl);
      if (indexOfUrl < 0) {
        throw new UniqueEntityNotFoundException(`The image that is being tried to be deleted with given URL 
            does not exist in the database.`);
      }
      const updatedImageUrls = imageUrls.splice(indexOfUrl, 1);
      const updatedHelpCenter = await this.prisma.helpCenter.update({
        where: {
          id: helpCenterId,
        },
        data: {
          helpCenterImageUrls: {
            set: updatedImageUrls,
          },
        },
      });
      return updatedHelpCenter.helpCenterImageUrls;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'Help center you are trying to update cannot be found in the system.',
          );
        }
      }
      throw e;
    }
  }

  async getUsersProfilePicture(userId: number) {
    try {
      const user = await this.prisma.user.findUnique({
        where: {
          id: userId,
        },
      });

      return user.profileImageUrl;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'User you are trying to access cannot be found in the system.',
          );
        }
      }
      throw e;
    }
  }

  async updateUsersProfilePicture(userImageDto: UserImageDto) {
    const { userId, imageUrl } = userImageDto;

    try {
      const user = await this.prisma.user.update({
        where: {
          id: userId,
        },
        data: {
          profileImageUrl: imageUrl,
        },
      });
      return user.profileImageUrl;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'User you are trying to access cannot be found in the system.',
          );
        }
      }
      throw e;
    }
  }

  async deleteUsersProfilePicture(userId: number) {
    try {
      const user = await this.prisma.user.update({
        where: {
          id: userId,
        },
        data: {
          profileImageUrl: '',
        },
      });
      return user.profileImageUrl;
    } catch (e) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === 'P2001') {
          throw new UniqueEntityNotFoundException(
            'User you are trying to access cannot be found in the system.',
          );
        }
      }
      throw e;
    }
  }
}
