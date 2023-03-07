/*
  Warnings:

  - You are about to drop the column `typeId` on the `NeededSupply` table. All the data in the column will be lost.
  - You are about to drop the column `typeId` on the `Supply` table. All the data in the column will be lost.
  - The primary key for the `SupplyType` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `SupplyType` table. All the data in the column will be lost.
  - Added the required column `supplyTypeCategory` to the `NeededSupply` table without a default value. This is not possible if the table is not empty.
  - Added the required column `supplyTypeName` to the `NeededSupply` table without a default value. This is not possible if the table is not empty.
  - Added the required column `supplyTypeCategory` to the `Supply` table without a default value. This is not possible if the table is not empty.
  - Added the required column `supplyTypeName` to the `Supply` table without a default value. This is not possible if the table is not empty.
  - Made the column `category` on table `SupplyType` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "NeededSupply" DROP CONSTRAINT "NeededSupply_typeId_fkey";

-- DropForeignKey
ALTER TABLE "Supply" DROP CONSTRAINT "Supply_typeId_fkey";

-- AlterTable
ALTER TABLE "NeededSupply" DROP COLUMN "typeId",
ADD COLUMN     "supplyTypeCategory" TEXT NOT NULL,
ADD COLUMN     "supplyTypeName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Supply" DROP COLUMN "typeId",
ADD COLUMN     "supplyTypeCategory" TEXT NOT NULL,
ADD COLUMN     "supplyTypeName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "SupplyType" DROP CONSTRAINT "SupplyType_pkey",
DROP COLUMN "id",
ALTER COLUMN "category" SET NOT NULL,
ADD CONSTRAINT "SupplyType_pkey" PRIMARY KEY ("typeName", "category");

-- AddForeignKey
ALTER TABLE "Supply" ADD CONSTRAINT "Supply_supplyTypeName_supplyTypeCategory_fkey" FOREIGN KEY ("supplyTypeName", "supplyTypeCategory") REFERENCES "SupplyType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededSupply" ADD CONSTRAINT "NeededSupply_supplyTypeName_supplyTypeCategory_fkey" FOREIGN KEY ("supplyTypeName", "supplyTypeCategory") REFERENCES "SupplyType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;
