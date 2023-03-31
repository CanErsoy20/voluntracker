/*
  Warnings:

  - You are about to drop the column `userId` on the `HelpCenterCoordinator` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `VolunteerTeamLeader` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[volunteerId]` on the table `HelpCenterCoordinator` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[helpCenterId,teamName]` on the table `VolunteerTeam` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[volunteerId]` on the table `VolunteerTeamLeader` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `volunteerId` to the `HelpCenterCoordinator` table without a default value. This is not possible if the table is not empty.
  - Added the required column `volunteerId` to the `VolunteerTeamLeader` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "HelpCenterCoordinator" DROP CONSTRAINT "HelpCenterCoordinator_userId_fkey";

-- DropForeignKey
ALTER TABLE "VolunteerTeamLeader" DROP CONSTRAINT "VolunteerTeamLeader_userId_fkey";

-- DropIndex
DROP INDEX "HelpCenterCoordinator_userId_key";

-- DropIndex
DROP INDEX "VolunteerTeamLeader_userId_key";

-- AlterTable
ALTER TABLE "HelpCenter" ADD COLUMN     "city" TEXT NOT NULL DEFAULT 'Ankara',
ADD COLUMN     "country" TEXT NOT NULL DEFAULT 'Turkey';

-- AlterTable
ALTER TABLE "HelpCenterCoordinator" DROP COLUMN "userId",
ADD COLUMN     "volunteerId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "VolunteerTeamLeader" DROP COLUMN "userId",
ADD COLUMN     "volunteerId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "recipient" TEXT NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "HelpCenterCoordinator_volunteerId_key" ON "HelpCenterCoordinator"("volunteerId");

-- CreateIndex
CREATE UNIQUE INDEX "VolunteerTeam_helpCenterId_teamName_key" ON "VolunteerTeam"("helpCenterId", "teamName");

-- CreateIndex
CREATE UNIQUE INDEX "VolunteerTeamLeader_volunteerId_key" ON "VolunteerTeamLeader"("volunteerId");

-- AddForeignKey
ALTER TABLE "VolunteerTeamLeader" ADD CONSTRAINT "VolunteerTeamLeader_volunteerId_fkey" FOREIGN KEY ("volunteerId") REFERENCES "Volunteer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HelpCenterCoordinator" ADD CONSTRAINT "HelpCenterCoordinator_volunteerId_fkey" FOREIGN KEY ("volunteerId") REFERENCES "Volunteer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
