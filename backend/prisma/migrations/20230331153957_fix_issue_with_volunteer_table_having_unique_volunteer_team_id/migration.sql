-- AlterEnum
ALTER TYPE "VolunteerTypeEnum" ADD VALUE 'SupplyCoordinator';

-- DropIndex
DROP INDEX "Volunteer_volunteerTeamId_key";
