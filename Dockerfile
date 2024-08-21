# Step 1: Build the React application
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the application source code
COPY . .

# Build the React application
RUN npm run build

# Step 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the build artifacts from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
