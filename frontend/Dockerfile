# Use the official Flutter Docker image as a base
FROM cirrusci/flutter:stable AS builder

# Set the working directory to the Flutter project folder
WORKDIR /app

# Copy the entire Flutter project folder into the Docker image
COPY . .

# Run the following commands to install the necessary dependencies
RUN flutter channel beta && flutter upgrade && flutter config --enable-web && flutter doctor && flutter pub get

# Build the Flutter web app
RUN flutter build web --release

# Use the official NGINX Docker image as a base
FROM nginx:stable-alpine

# Copy the built Flutter web app to the NGINX web root directory
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX and serve the Flutter web app
CMD ["nginx", "-g", "daemon off;"]