import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
prisma.$connect();

async function main() {
  const users = await prisma.user.findMany();
  console.log(users);
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

console.log("Hello, world!");
