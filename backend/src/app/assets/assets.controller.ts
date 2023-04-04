import { Body, Controller, Delete, Get, Param, Patch } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { HttpResponse } from 'src/common';
import { AssetsService } from './assets.service';
import { UserImageDto } from './dto/user-image.dto';

@ApiTags('Assets')
@Controller('assets')
export class AssetsController {
  constructor(private readonly assetsService: AssetsService) {}

  // Get help center images
  @Get('/images/helpCenters/:helpCenterId')
  async getHelpCenterImages(@Param('helpCenterId') helpCenterId: string) {
    const imageUrls: string[] = await this.assetsService.getHelpCenterImages(+helpCenterId);
    return new HttpResponse({ imageUrls }, 'Successfully fetched all the help center images', 200);
  }
  // Update help center images
  @Patch('/images/helpCenters/:helpCenterId/:oldUrl/:newUrl')
  async updateHelpCenterImages(
    @Param('helpCenterId') helpCenterId: string,
    @Param('newUrl') newUrl: string,
    @Param('oldUrl') oldUrl: string,
  ) {
    const updatedImageUrls = await this.assetsService.updateHelpCenterImages(+helpCenterId, oldUrl, newUrl);
    return new HttpResponse(
      { imageUrls: updatedImageUrls },
      'Successfully updated the image for help center.',
      200,
    );
  }

  // Delete help center image
  @Delete('/images/helpCenters/:helpCenterId/:imageUrl')
  async deleteHelpCenterImage(@Param('id') helpCenterId: string, @Param('imageUrl') imageUrl: string) {
    const imageUrls: string[] = await this.assetsService.deleteHelpCenterImage(+helpCenterId, imageUrl);
    return new HttpResponse({ imageUrls }, 'Successfully deleted the image from help center.', 200);
  }

  // Get profile image
  @Get('/images/users/:userId/profile')
  async getUserImage(@Param('userId') userId: string) {
    const imageUrl = await this.assetsService.getUsersProfilePicture(+userId);
    return new HttpResponse({ imageUrl }, 'Successfully fetched all the help center images', 200);
  }

  // Update profile image
  @Patch('/images/users/profile')
  async updateUserImage(@Body() userImageDto: UserImageDto) {
    const updatedUserProfileImage = await this.assetsService.updateUsersProfilePicture(userImageDto);
    return new HttpResponse(
      { imageUrl: updatedUserProfileImage },
      'Successfully fetched all the help center images',
      200,
    );
  }

  // Delete profile image
  @Delete('/images/users/:userId/profile')
  async deleteUserImage(@Param('userId') userId: string) {
    const deletedProfileImage = await this.assetsService.deleteUsersProfilePicture(+userId);
    return new HttpResponse(
      { imageUrl: deletedProfileImage },
      'Successfully fetched all the help center images',
      200,
    );
  }
}
