# Stage 1: Build React app
FROM node:20.6.1-alpine3.18 as build
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve React app with Nginx
FROM nginx:latest
COPY --from=build /app/dist /usr/share/nginx/html
COPY /app/.env /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8001
CMD ["nginx", "-g", "daemon off;"]