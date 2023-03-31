/*
  Warnings:

  - You are about to drop the column `lastGenerationAt` on the `QrCode` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[uuid]` on the table `QrCode` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "QrCode" DROP COLUMN "lastGenerationAt";

-- CreateIndex
CREATE UNIQUE INDEX "QrCode_uuid_key" ON "QrCode"("uuid");
