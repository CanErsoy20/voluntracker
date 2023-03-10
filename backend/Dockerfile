# Set the base image to Node.js
FROM node:18

COPY package.json /app/
COPY package-lock.json /app/

# Create a directory for the app
WORKDIR /app/

# Copy package.json and package-lock.json into the container
#COPY package*.json ./

# Install dependencies
RUN npm install

RUN ls

RUN ls /app/
# Install the Nest CLI globally
#RUN npm install -g @nestjs/cli

# Copy the rest of the application into the container
COPY . /app/

RUN ls /app/
# Generate Prisma Client
RUN npx prisma generate

# Build the application
RUN npm run build

# Expose the port that the app listens on
#EXPOSE 3000

# Start the application
CMD ["npm", "start"]

