/*
  Warnings:

  - A unique constraint covering the columns `[helpCenterId,volunteerId]` on the table `VolunteersFollowingHelpCenters` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "VolunteersFollowingHelpCenters_helpCenterId_volunteerId_key" ON "VolunteersFollowingHelpCenters"("helpCenterId", "volunteerId");
