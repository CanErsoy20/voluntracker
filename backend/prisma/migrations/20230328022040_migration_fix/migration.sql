/*
  Warnings:

  - You are about to drop the column `role_name` on the `UserRole` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[roleName]` on the table `UserRole` will be added. If there are existing duplicate values, this will fail.
  - Made the column `roleId` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `roleName` to the `UserRole` table without a default value. This is not possible if the table is not empty.
  - Made the column `volunteerTypeName` on table `Volunteer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `volunteerTypeCategory` on table `Volunteer` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_roleId_fkey";

-- DropForeignKey
ALTER TABLE "Volunteer" DROP CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey";

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "roleId" SET NOT NULL;

-- AlterTable
ALTER TABLE "UserRole" DROP COLUMN "role_name",
ADD COLUMN     "roleName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Volunteer" ALTER COLUMN "volunteerTypeName" SET NOT NULL,
ALTER COLUMN "volunteerTypeCategory" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "UserRole_roleName_key" ON "UserRole"("roleName");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;
