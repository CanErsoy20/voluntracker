# Set the base image to Node.js
FROM node:18

WORKDIR /app/

COPY package.json /app/
COPY package-lock.json /app/

RUN cat ./package.json
# Create a directory for the app

# Copy package.json and package-lock.json into the container
#COPY package*.json ./

# Install dependencies
RUN npm install

RUN ls .
# Install the Nest CLI globally
#RUN npm install -g @nestjs/cli

# Copy the rest of the application into the container
COPY . .

RUN ls .
# Generate Prisma Client
RUN npx prisma generate

# Build the application
RUN npm run build

#RUN npx prisma migrate dev

# Expose the port that the app listens on
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start:migrate"]


