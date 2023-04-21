FROM node:14-alpine

WORKDIR /app

COPY nurse-app/package*.json ./

RUN npm install

COPY nurse-app .

RUN npm run build

EXPOSE 5173

CMD ["npm", "run", "dev"]
