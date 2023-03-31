-- AlterTable
ALTER TABLE "VolunteerTeam" ADD COLUMN     "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "VolunteersFollowingHelpCenters" (
    "id" SERIAL NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "volunteerId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "VolunteersFollowingHelpCenters_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "VolunteersFollowingHelpCenters" ADD CONSTRAINT "VolunteersFollowingHelpCenters_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VolunteersFollowingHelpCenters" ADD CONSTRAINT "VolunteersFollowingHelpCenters_volunteerId_fkey" FOREIGN KEY ("volunteerId") REFERENCES "Volunteer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
