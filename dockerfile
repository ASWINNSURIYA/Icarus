# Use the official Node.js image based on Alpine Linux
FROM node:alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json first to leverage Docker caching
COPY package.json package-lock.json /app/

# Install dependencies
RUN npm install

# Install live-server globally to avoid permission issues
RUN npm install -g live-server

# Copy the rest of the application files
COPY . /app/

# Fix permissions for the live-server binary
RUN chmod +x /app/node_modules/.bin/live-server

# Ensure all node modules have correct permissions (optional)
RUN chmod -R 755 /app/node_modules

# Expose the port where the server will be running (default for live-server is 3000)
EXPOSE 3000

# Run the live-server with npm start
CMD ["npm", "start"]
