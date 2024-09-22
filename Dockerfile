FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build


FROM node:22-alpine AS prisma

WORKDIR /app

COPY package*.json .

RUN npm install prisma

COPY prisma ./prisma

RUN npx prisma generate


FROM node:22-alpine AS production

WORKDIR /app

COPY package.json .

RUN npm install --omit=dev

COPY --from=prisma /app/node_modules/.prisma/client node_modules/.prisma/client

COPY --from=build /app/dist/ build/

EXPOSE 3000

CMD ["node", "build"]