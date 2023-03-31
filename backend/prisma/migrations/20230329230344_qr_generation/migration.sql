-- CreateTable
CREATE TABLE "QrCode" (
    "id" SERIAL NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "uuid" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastGenerationAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "QrCode_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "QrCode_helpCenterId_key" ON "QrCode"("helpCenterId");

-- AddForeignKey
ALTER TABLE "QrCode" ADD CONSTRAINT "QrCode_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
