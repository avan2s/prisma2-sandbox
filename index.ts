import { PrismaClient, User } from '@prisma/client'

const prisma = new PrismaClient({
    log: [
        {
            emit: "event",
            level: "query",
        }
    ]
});

prisma.$on("query", async (e) => {
    console.log(`${e.query} ${e.params}`)
});

async function main() {
    // ... you will write your Prisma Client queries here
    console.log(await prisma.post.deleteMany());
    console.log(await prisma.profile.deleteMany());
    console.log(await prisma.user.deleteMany());

    const user = await prisma.user.create(
        {
            data: {
                username: 'Alice',
                email: 'alice@prisma.io',
                posts: {
                    create: {
                        title: 'Hello world',
                        content: 'You are a strange guy'
                    }
                },
                profile: {
                    create: { bio: 'I like turtles' }
                }
            }
        }
    );
    console.log('created user ' + JSON.stringify(user));

    const result = await prisma.$queryRaw<User[]>`SELECT 'andreas' AS name, 'a@a.de' AS email`;
    console.log("raw Query result: " + result);

    const updated = await prisma.post.updateMany({
        where: {
            authorId: user.id
        },
        data: { published: true },
    })
    console.log('update user ' + JSON.stringify(updated));

    const allUsers = await prisma.user.findMany();
    console.log(allUsers);
}

main()
    .catch((e) => {
        throw e
    })
    .finally(async () => {
        await prisma.$disconnect()
    })
