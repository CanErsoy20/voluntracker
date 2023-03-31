-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'MedicalSupply';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'ShelterMaterial';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'Clothing';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'PersonalHygieneProducts';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'ToolsAndEquipment';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'CommunicationDevices';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'CleaningProducts';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'PowerSources';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'CookingSupplies';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'EducationalMaterials';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'ConstructionMaterials';
ALTER TYPE "SupplyCategoryEnum" ADD VALUE 'AnimalSupplies';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "SupplyTypeEnum" ADD VALUE 'CannedVegetable';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'CannedFruit';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Rice';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Bread';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Cereal';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'InstantNoodle';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Biscuit';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Cracker';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'EnergyBar';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Flour';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Sugar';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Salt';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Spice';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'CookingOil';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'ProteinBar';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'InfantMilk';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'BottledWater';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Tea';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Coffee';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'FruitJuice';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'VegetableJuice';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Bandage';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Gauze';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'AntisepticWipes';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'DisposableGloves';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'FaceMasks';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'SterileSyringes';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Tourniquet';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'FirstAidKit';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PrescriptionMedications';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'OxygenTank';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Thermometer';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Epipen';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Antiacid';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Blanket';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'SleepingBag';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Tent';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Tshirt';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Sweatshirt';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Pants';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Short';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Underwear';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Sock';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Shoe';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Sandal';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Boot';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Raincoat';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'WinterCoat';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Hat';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Glove';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Scarve';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Sunglass';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Belt';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Pajama';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Bathrobe';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Soap';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Shampoo';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Toothbrush';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Toothpaste';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'DentalFloss';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Razor';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'ShavingCream';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Deodorant';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Tissue';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'ToiletPaper';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'WetWipe';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'InsectRepellant';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'ContactLensSolution';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'NailClipper';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Pad';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Tampon';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Hammer';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Screwdriver';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Wrench';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Plier';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Handsaw';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Axe';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Shovel';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Rake';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Whellbarrow';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Crowbar';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'WireCutter';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'UtilityKnife';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'DuctTape';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Rope';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Chainsaw';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Nail';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Fuel';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PortableRadio';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'SattelitePhone';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'CellPhone';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'EmergencyWhistle';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PortableWifiHotspot';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Bleach';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'DisinfectantWipe';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'TrashBag';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Mop';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Broom';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Dustpan';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Sponge';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Bucket';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'MicrofiberCloths';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Battery';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Generator';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PowerBank';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PortableStove';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PropaneTank';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'CampingCookwareSet';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Spatula';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Plate';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Bowl';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Fork';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Knive';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Spoon';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PaperPlate';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'PlasticUtensil';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'CanOpener';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'ChildrenBook';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'Book';
ALTER TYPE "SupplyTypeEnum" ADD VALUE 'AnimalFood';
