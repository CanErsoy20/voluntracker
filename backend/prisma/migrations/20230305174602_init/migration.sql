-- CreateTable
CREATE TABLE "HelpCenter" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "busiestHours" JSONB,
    "openCloseInfo" JSONB,
    "location" JSONB,
    "contactInfo" JSONB,
    "additionalInfo" TEXT,
    "volunteerCapacity" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HelpCenter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supply" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "typeId" INTEGER NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Supply_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NeededSupply" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "urgency" INTEGER,
    "typeId" INTEGER NOT NULL,
    "helpCenterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NeededSupply_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplyType" (
    "id" SERIAL NOT NULL,
    "typeName" TEXT NOT NULL,
    "category" TEXT,

    CONSTRAINT "SupplyType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Volunteer" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "volunteerTypeId" INTEGER NOT NULL,
    "helpCenterId" INTEGER NOT NULL,

    CONSTRAINT "Volunteer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NeededVolunteer" (
    "id" SERIAL NOT NULL,
    "quantity" INTEGER NOT NULL,
    "urgency" INTEGER,
    "volunteerTypeId" INTEGER NOT NULL,
    "helpCenterId" INTEGER NOT NULL,

    CONSTRAINT "NeededVolunteer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VolunteerType" (
    "id" SERIAL NOT NULL,
    "typeName" TEXT NOT NULL,
    "category" TEXT NOT NULL,

    CONSTRAINT "VolunteerType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRole" (
    "id" SERIAL NOT NULL,
    "role_name" TEXT NOT NULL,

    CONSTRAINT "UserRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" SERIAL NOT NULL,
    "permissionName" TEXT NOT NULL,
    "permissionKey" TEXT NOT NULL,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RolePermission" (
    "id" SERIAL NOT NULL,
    "permissionId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Supply" ADD CONSTRAINT "Supply_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "SupplyType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Supply" ADD CONSTRAINT "Supply_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededSupply" ADD CONSTRAINT "NeededSupply_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "SupplyType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededSupply" ADD CONSTRAINT "NeededSupply_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_volunteerTypeId_fkey" FOREIGN KEY ("volunteerTypeId") REFERENCES "VolunteerType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Volunteer" ADD CONSTRAINT "Volunteer_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededVolunteer" ADD CONSTRAINT "NeededVolunteer_volunteerTypeId_fkey" FOREIGN KEY ("volunteerTypeId") REFERENCES "VolunteerType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NeededVolunteer" ADD CONSTRAINT "NeededVolunteer_helpCenterId_fkey" FOREIGN KEY ("helpCenterId") REFERENCES "HelpCenter"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "Permission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePermission" ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "UserRole"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
