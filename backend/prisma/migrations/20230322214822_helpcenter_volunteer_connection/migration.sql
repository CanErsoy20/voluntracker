-- AlterTable
ALTER TABLE "Volunteer" ADD COLUMN     "helpCenterId" INTEGER;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE SET NULL ON UPDATE CASCADE;
