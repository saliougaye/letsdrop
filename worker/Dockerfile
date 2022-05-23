FROM node:17-alpine

WORKDIR /home/app

COPY package*.json ./

RUN npm i

COPY . .

RUN npm run build

CMD ["npm", "start"]