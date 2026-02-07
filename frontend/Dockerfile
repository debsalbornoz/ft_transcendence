# Dockerfile para o serviço frontend (Next.js)

FROM node:20-alpine AS base
WORKDIR /app

# Copia apenas as definições de dependências e instala
COPY package*.json ./
RUN npm install --production

# Copia o restante da aplicação e constrói
COPY . .
RUN npm run build

# Expõe a porta padrão do Next.js
EXPOSE 3000

CMD ["npm", "start"]