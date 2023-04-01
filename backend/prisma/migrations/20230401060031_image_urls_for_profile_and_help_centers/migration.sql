-- AlterTable
ALTER TABLE "HelpCenter" ADD COLUMN     "helpCenterImageUrls" TEXT[];

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "profileImageUrl" TEXT DEFAULT '';
