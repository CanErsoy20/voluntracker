/*
  Warnings:

  - You are about to drop the column `volunteerTypeId` on the `NeededVolunteer` table. All the data in the column will be lost.
  - You are about to drop the column `volunteerTypeId` on the `Volunteer` table. All the data in the column will be lost.
  - The primary key for the `VolunteerType` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `VolunteerType` table. All the data in the column will be lost.
  - Added the required column `volunteerTypeCategory` to the `NeededVolunteer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `volunteerTypeName` to the `NeededVolunteer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `volunteerTypeCategory` to the `Volunteer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `volunteerTypeName` to the `Volunteer` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "NeededVolunteer" DROP CONSTRAINT "NeededVolunteer_volunteerTypeId_fkey";

-- DropForeignKey
ALTER TABLE "Volunteer" DROP CONSTRAINT "Volunteer_volunteerTypeId_fkey";

-- AlterTable
ALTER TABLE "NeededVolunteer" DROP COLUMN "volunteerTypeId",
ADD COLUMN     "volunteerTypeCategory" TEXT NOT NULL,
ADD COLUMN     "volunteerTypeName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Volunteer" DROP COLUMN "volunteerTypeId",
ADD COLUMN     "volunteerTypeCategory" TEXT NOT NULL,
ADD COLUMN     "volunteerTypeName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "VolunteerType" DROP CONSTRAINT "VolunteerType_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "VolunteerType_pkey" PRIMARY KEY ("typeName", "category");

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededVolunteer" ADD CONSTRAINT "NeededVolunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;
