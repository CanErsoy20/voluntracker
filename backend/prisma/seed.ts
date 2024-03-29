import { Logger } from '@nestjs/common';
import { PrismaClient, SupplyCategoryEnum, SupplyTypeEnum } from '@prisma/client';

type TypeCategoryObject = {
  typeName: SupplyTypeEnum;
  category: SupplyCategoryEnum;
};

export const supplyTypeCategoryObjects: TypeCategoryObject[] = [
  { typeName: 'CannedVegetable', category: 'Food' },
  { typeName: 'CannedFruit', category: 'Food' },
  { typeName: 'Rice', category: 'Food' },
  { typeName: 'Pasta', category: 'Food' },
  { typeName: 'Bread', category: 'Food' },
  { typeName: 'Cereal', category: 'Food' },
  { typeName: 'InstantNoodle', category: 'Food' },
  { typeName: 'Biscuit', category: 'Food' },
  { typeName: 'Cracker', category: 'Food' },
  { typeName: 'EnergyBar', category: 'Food' },
  { typeName: 'Flour', category: 'Food' },
  { typeName: 'Sugar', category: 'Food' },
  { typeName: 'Salt', category: 'Food' },
  { typeName: 'Spice', category: 'Food' },
  { typeName: 'CookingOil', category: 'Food' },
  { typeName: 'ProteinBar', category: 'Food' },
  { typeName: 'InfantMilk', category: 'Drink' },
  { typeName: 'BottledWater', category: 'Drink' },
  { typeName: 'Tea', category: 'Drink' },
  { typeName: 'Coffee', category: 'Drink' },
  { typeName: 'FruitJuice', category: 'Drink' },
  { typeName: 'VegetableJuice', category: 'Drink' },
  { typeName: 'Bandage', category: 'MedicalSupply' },
  { typeName: 'Gauze', category: 'MedicalSupply' },
  { typeName: 'AntisepticWipes', category: 'MedicalSupply' },
  { typeName: 'DisposableGloves', category: 'MedicalSupply' },
  { typeName: 'FaceMasks', category: 'MedicalSupply' },
  { typeName: 'SterileSyringes', category: 'MedicalSupply' },
  { typeName: 'Tourniquet', category: 'MedicalSupply' },
  { typeName: 'FirstAidKit', category: 'MedicalSupply' },
  { typeName: 'PrescriptionMedications', category: 'MedicalSupply' },
  { typeName: 'OxygenTank', category: 'MedicalSupply' },
  { typeName: 'Thermometer', category: 'MedicalSupply' },
  { typeName: 'Epipen', category: 'MedicalSupply' },
  { typeName: 'Antiacid', category: 'MedicalSupply' },
  { typeName: 'Blanket', category: 'ShelterMaterial' },
  { typeName: 'SleepingBag', category: 'ShelterMaterial' },
  { typeName: 'Tent', category: 'ShelterMaterial' },
  { typeName: 'Tshirt', category: 'Clothing' },
  { typeName: 'Sweatshirt', category: 'Clothing' },
  { typeName: 'Pants', category: 'Clothing' },
  { typeName: 'Short', category: 'Clothing' },
  { typeName: 'Underwear', category: 'Clothing' },
  { typeName: 'Sock', category: 'Clothing' },
  { typeName: 'Shoe', category: 'Clothing' },
  { typeName: 'Sandal', category: 'Clothing' },
  { typeName: 'Boot', category: 'Clothing' },
  { typeName: 'Raincoat', category: 'Clothing' },
  { typeName: 'WinterCoat', category: 'Clothing' },
  { typeName: 'Hat', category: 'Clothing' },
  { typeName: 'Glove', category: 'Clothing' },
  { typeName: 'Scarve', category: 'Clothing' },
  { typeName: 'Sunglass', category: 'Clothing' },
  { typeName: 'Belt', category: 'Clothing' },
  { typeName: 'Pajama', category: 'Clothing' },
  { typeName: 'Bathrobe', category: 'Clothing' },
  { typeName: 'Soap', category: 'PersonalHygieneProducts' },
  { typeName: 'Shampoo', category: 'PersonalHygieneProducts' },
  { typeName: 'Toothbrush', category: 'PersonalHygieneProducts' },
  { typeName: 'Toothpaste', category: 'PersonalHygieneProducts' },
  { typeName: 'DentalFloss', category: 'PersonalHygieneProducts' },
  { typeName: 'Razor', category: 'PersonalHygieneProducts' },
  { typeName: 'ShavingCream', category: 'PersonalHygieneProducts' },
  { typeName: 'Deodorant', category: 'PersonalHygieneProducts' },
  { typeName: 'Tissue', category: 'PersonalHygieneProducts' },
  { typeName: 'ToiletPaper', category: 'PersonalHygieneProducts' },
  { typeName: 'WetWipe', category: 'PersonalHygieneProducts' },
  { typeName: 'InsectRepellant', category: 'PersonalHygieneProducts' },
  { typeName: 'ContactLensSolution', category: 'PersonalHygieneProducts' },
  { typeName: 'NailClipper', category: 'PersonalHygieneProducts' },
  { typeName: 'Pad', category: 'PersonalHygieneProducts' },
  { typeName: 'Tampon', category: 'PersonalHygieneProducts' },
  { typeName: 'Hammer', category: 'ToolsAndEquipment' },
  { typeName: 'Screwdriver', category: 'ToolsAndEquipment' },
  { typeName: 'Wrench', category: 'ToolsAndEquipment' },
  { typeName: 'Plier', category: 'ToolsAndEquipment' },
  { typeName: 'Handsaw', category: 'ToolsAndEquipment' },
  { typeName: 'Axe', category: 'ToolsAndEquipment' },
  { typeName: 'Shovel', category: 'ToolsAndEquipment' },
  { typeName: 'Rake', category: 'ToolsAndEquipment' },
  { typeName: 'Whellbarrow', category: 'ToolsAndEquipment' },
  { typeName: 'Crowbar', category: 'ToolsAndEquipment' },
  { typeName: 'WireCutter', category: 'ToolsAndEquipment' },
  { typeName: 'UtilityKnife', category: 'ToolsAndEquipment' },
  { typeName: 'DuctTape', category: 'ToolsAndEquipment' },
  { typeName: 'Rope', category: 'ToolsAndEquipment' },
  { typeName: 'Chainsaw', category: 'ToolsAndEquipment' },
  { typeName: 'Nail', category: 'ToolsAndEquipment' },
  { typeName: 'Fuel', category: 'ToolsAndEquipment' },
  { typeName: 'PortableRadio', category: 'CommunicationDevices' },
  { typeName: 'SattelitePhone', category: 'CommunicationDevices' },
  { typeName: 'CellPhone', category: 'CommunicationDevices' },
  { typeName: 'EmergencyWhistle', category: 'CommunicationDevices' },
  { typeName: 'PortableWifiHotspot', category: 'CommunicationDevices' },
  { typeName: 'Bleach', category: 'CleaningProducts' },
  { typeName: 'DisinfectantWipe', category: 'CleaningProducts' },
  { typeName: 'TrashBag', category: 'CleaningProducts' },
  { typeName: 'Mop', category: 'CleaningProducts' },
  { typeName: 'Broom', category: 'CleaningProducts' },
  { typeName: 'Dustpan', category: 'CleaningProducts' },
  { typeName: 'Sponge', category: 'CleaningProducts' },
  { typeName: 'Bucket', category: 'CleaningProducts' },
  { typeName: 'MicrofiberCloths', category: 'CleaningProducts' },
  { typeName: 'Battery', category: 'PowerSources' },
  { typeName: 'Generator', category: 'PowerSources' },
  { typeName: 'PowerBank', category: 'PowerSources' },
  { typeName: 'PortableStove', category: 'CookingSupplies' },
  { typeName: 'PropaneTank', category: 'CookingSupplies' },
  { typeName: 'CampingCookwareSet', category: 'CookingSupplies' },
  { typeName: 'Spatula', category: 'CookingSupplies' },
  { typeName: 'Plate', category: 'CookingSupplies' },
  { typeName: 'Bowl', category: 'CookingSupplies' },
  { typeName: 'Fork', category: 'CookingSupplies' },
  { typeName: 'Knive', category: 'CookingSupplies' },
  { typeName: 'Spoon', category: 'CookingSupplies' },
  { typeName: 'PaperPlate', category: 'CookingSupplies' },
  { typeName: 'PlasticUtensil', category: 'CookingSupplies' },
  { typeName: 'CanOpener', category: 'CookingSupplies' },
  { typeName: 'ChildrenBook', category: 'EducationalMaterials' },
  { typeName: 'Book', category: 'EducationalMaterials' },
  { typeName: 'AnimalFood', category: 'AnimalSupplies' },
];

const prisma = new PrismaClient();
const logger: Logger = new Logger();
async function main() {
  await prisma.supplyType.createMany({
    data: [...supplyTypeCategoryObjects],
    skipDuplicates: true,
  });

  // TODO: Seed volunteer type, volunter category
  await prisma.volunteerType.createMany({
    data: [
      { category: 'Labor', typeName: 'Carrier' },
      { category: 'Management', typeName: 'Carrier' },
    ],
    skipDuplicates: true,
  });

  // TODO: Seed user role

  await prisma.userRole.createMany({
    data: [
      { roleName: 'Volunteer' },
      { roleName: 'HelpCenterCoordinator' },
      { roleName: 'VolunteerTeamLeader' },
      { roleName: 'Admin' },
    ],
    skipDuplicates: true,
  });
}

main()
  .catch((e) => {
    logger.log(e);
    console.error(e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
