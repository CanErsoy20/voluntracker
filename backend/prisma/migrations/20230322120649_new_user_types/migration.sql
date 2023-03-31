-- CreateEnum
CREATE TYPE "SupplyTypeEnum" AS ENUM ('Pasta');

-- CreateEnum
CREATE TYPE "SupplyCategoryEnum" AS ENUM ('Food', 'Drink');

-- CreateEnum
CREATE TYPE "VolunteerTypeEnum" AS ENUM ('Carrier');

-- CreateEnum
CREATE TYPE "VolunteerCategoryEnum" AS ENUM ('Management', 'Labor');

-- CreateEnum
CREATE TYPE "UrgencyEnum" AS ENUM ('Low', 'Medium', 'High');

-- CreateTable
CREATE TABLE "HelpCenter" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "busiestHours" JSONB NOT NULL,
    "openCloseInfo" JSONB NOT NULL,
    "location" JSONB NOT NULL,
    "contactInfo" JSONB NOT NULL,
    "additionalInfo" TEXT NOT NULL,
    "volunteerCapacity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HelpCenter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supply" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "supplyTypeName" "SupplyTypeEnum" NOT NULL,
    "supplyTypeCategory" "SupplyCategoryEnum" NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Supply_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NeededSupply" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "urgency" "UrgencyEnum",
    "supplyTypeName" "SupplyTypeEnum" NOT NULL,
    "supplyTypeCategory" "SupplyCategoryEnum" NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NeededSupply_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplyType" (
    "typeName" "SupplyTypeEnum" NOT NULL,
    "category" "SupplyCategoryEnum" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SupplyType_pkey" PRIMARY KEY ("typeName","category")
);

-- CreateTable
CREATE TABLE "NeededVolunteer" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "urgency" "UrgencyEnum",
    "volunteerTypeName" "VolunteerTypeEnum" NOT NULL,
    "volunteerTypeCategory" "VolunteerCategoryEnum" NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NeededVolunteer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "firstname" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "password" TEXT NOT NULL,
    "roleId" INTEGER,
    "hashedRefreshToken" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRole" (
    "id" SERIAL NOT NULL,
    "role_name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RolePermission" (
    "id" SERIAL NOT NULL,
    "permissionId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" SERIAL NOT NULL,
    "permissionName" TEXT NOT NULL,
    "permissionKey" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Volunteer" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "volunteerTypeName" "VolunteerTypeEnum" NOT NULL,
    "volunteerTypeCategory" "VolunteerCategoryEnum" NOT NULL,
    "volunteerTeamId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Volunteer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GuestVolunteer" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "volunteerTypeName" "VolunteerTypeEnum" NOT NULL,
    "volunteerTypeCategory" "VolunteerCategoryEnum" NOT NULL,
    "volunteerTeamId" INTEGER NOT NULL,

    CONSTRAINT "GuestVolunteer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VolunteerType" (
    "typeName" "VolunteerTypeEnum" NOT NULL,
    "category" "VolunteerCategoryEnum" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VolunteerType_pkey" PRIMARY KEY ("typeName","category")
);

-- CreateTable
CREATE TABLE "VolunteerTeamLeader" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "volunteerTeamId" INTEGER NOT NULL,

    CONSTRAINT "VolunteerTeamLeader_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VolunteerTeam" (
    "id" SERIAL NOT NULL,
    "helpCenterId" INTEGER NOT NULL,

    CONSTRAINT "VolunteerTeam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HelpCenterCoordinator" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "helpCenterId" INTEGER NOT NULL,

    CONSTRAINT "HelpCenterCoordinator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Admin" (
    "userId" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "User"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "Volunteer_userId_key" ON "Volunteer"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Volunteer_volunteerTeamId_key" ON "Volunteer"("volunteerTeamId");

-- CreateIndex
CREATE UNIQUE INDEX "GuestVolunteer_volunteerTeamId_key" ON "GuestVolunteer"("volunteerTeamId");

-- CreateIndex
CREATE UNIQUE INDEX "GuestVolunteer_volunteerTypeName_volunteerTypeCategory_volu_key" ON "GuestVolunteer"("volunteerTypeName", "volunteerTypeCategory", "volunteerTeamId");

-- CreateIndex
CREATE UNIQUE INDEX "VolunteerTeamLeader_userId_key" ON "VolunteerTeamLeader"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "VolunteerTeamLeader_volunteerTeamId_key" ON "VolunteerTeamLeader"("volunteerTeamId");

-- CreateIndex
CREATE UNIQUE INDEX "HelpCenterCoordinator_userId_key" ON "HelpCenterCoordinator"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "HelpCenterCoordinator_helpCenterId_key" ON "HelpCenterCoordinator"("helpCenterId");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_userId_key" ON "Admin"("userId");

-- AddForeignKey
ALTER TABLE "Supply" ADD CONSTRAINT "Supply_supplyTypeName_supplyTypeCategory_fkey" FOREIGN KEY ("supplyTypeName", "supplyTypeCategory") REFERENCES "SupplyType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Supply" ADD CONSTRAINT "Supply_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededSupply" ADD CONSTRAINT "NeededSupply_supplyTypeName_supplyTypeCategory_fkey" FOREIGN KEY ("supplyTypeName", "supplyTypeCategory") REFERENCES "SupplyType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededSupply" ADD CONSTRAINT "NeededSupply_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededVolunteer" ADD CONSTRAINT "NeededVolunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededVolunteer" ADD CONSTRAINT "NeededVolunteer_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "Permission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTeamId_fkey" FOREIGN KEY ("volunteerTeamId") REFERENCES "VolunteerTeam"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GuestVolunteer" ADD CONSTRAINT "GuestVolunteer_volunteerTypeName_volunteerTypeCategory_fkey" FOREIGN KEY ("volunteerTypeName", "volunteerTypeCategory") REFERENCES "VolunteerType"("typeName", "category") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GuestVolunteer" ADD CONSTRAINT "GuestVolunteer_volunteerTeamId_fkey" FOREIGN KEY ("volunteerTeamId") REFERENCES "VolunteerTeam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VolunteerTeamLeader" ADD CONSTRAINT "VolunteerTeamLeader_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VolunteerTeamLeader" ADD CONSTRAINT "VolunteerTeamLeader_volunteerTeamId_fkey" FOREIGN KEY ("volunteerTeamId") REFERENCES "VolunteerTeam"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VolunteerTeam" ADD CONSTRAINT "VolunteerTeam_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HelpCenterCoordinator" ADD CONSTRAINT "HelpCenterCoordinator_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HelpCenterCoordinator" ADD CONSTRAINT "HelpCenterCoordinator_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
