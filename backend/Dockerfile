# Dockerfile para o serviço backend (Node.js + Express)

FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install --production

# Copia o restante do código da aplicação
COPY . .

EXPOSE 8000

CMD ["npm", "start"]