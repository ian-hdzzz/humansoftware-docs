# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

COPY my-docs/package*.json ./
RUN npm ci

COPY my-docs/ .
RUN npm run build

# Stage 2: Serve con nginx
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html
COPY my-docs/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
