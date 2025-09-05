FROM node:18-alpine AS builder
WORKDIR /app
COPY app/package*.json ./
RUN npm install
COPY app/ ./

# Сборка
RUN npm run build

# Основной образ
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]