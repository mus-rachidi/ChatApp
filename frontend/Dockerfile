FROM node:latest

WORKDIR /app

COPY ./app/package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
