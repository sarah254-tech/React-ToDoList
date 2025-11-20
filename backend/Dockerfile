# Stage 1: Use Node base image
FROM node:22.11.0-alpine

# Create app directory
WORKDIR /app

# Copy dependency files first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the backend code
COPY . .

# Expose backend port
EXPOSE 5000

# Environment variables (you can override later)
ENV NODE_ENV=production

# Start the server
CMD ["npm", "start"]
