/*
  Warnings:

  - You are about to drop the column `roleId` on the `User` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_roleId_fkey";

-- DropForeignKey
ALTER TABLE "Volunteer" DROP CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "roleId";

-- AlterTable
ALTER TABLE "Volunteer" ALTER COLUMN "volunteerTypeName" DROP NOT NULL,
ALTER COLUMN "volunteerTypeCategory" DROP NOT NULL;

-- CreateTable
CREATE TABLE "UserRolesOnUsers" (
    "userId" INTEGER NOT NULL,
    "userRoleName" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserRolesOnUsers_pkey" PRIMARY KEY ("userId","userRoleName")
);

-- AddForeignKey
ALTER TABLE "UserRolesOnUsers" ADD CONSTRAINT "UserRolesOnUsers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRolesOnUsers" ADD CONSTRAINT "UserRolesOnUsers_userRoleName_fkey" FOREIGN KEY ("userRoleName") REFERENCES "UserRole"("roleName") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE SET NULL ON UPDATE CASCADE;
