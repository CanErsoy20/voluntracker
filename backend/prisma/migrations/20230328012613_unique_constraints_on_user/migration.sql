-- DropForeignKey
ALTER TABLE "Volunteer" DROP CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey";

-- AlterTable
ALTER TABLE "Volunteer" ALTER COLUMN "volunteerTypeName" DROP NOT NULL,
ALTER COLUMN "volunteerTypeCategory" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "User" ALTER COLUMN "roleId" DROP NOT NULL
