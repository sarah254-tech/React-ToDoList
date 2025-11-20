# Stage 1: Build the Vite React app
FROM node:22-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Build the production files
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy build output to Nginx's default public folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 (the port Nginx listens on)
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
