-- CreateTable
CREATE TABLE "ecp_post" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT,
    "published" BOOLEAN NOT NULL DEFAULT false,
    "authorId" INTEGER NOT NULL,

    CONSTRAINT "ecp_post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecp_profile" (
    "id" SERIAL NOT NULL,
    "bio" TEXT,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "ecp_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecp_user" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT,

    CONSTRAINT "ecp_user_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ecp_profile_userId_key" ON "ecp_profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ecp_user_email_key" ON "ecp_user"("email");

-- AddForeignKey
ALTER TABLE "ecp_post" ADD CONSTRAINT "ecp_post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "ecp_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecp_profile" ADD CONSTRAINT "ecp_profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "ecp_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
