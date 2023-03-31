import { PrismaClient } from '@prisma/client';
import { supplyTypeCategoryObjects } from 'src/app/help-zones/needed-supply/constants';
const prisma = new PrismaClient();
async function main() {
  await prisma.supplyType.createMany({
    data: [...supplyTypeCategoryObjects],
  });
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
