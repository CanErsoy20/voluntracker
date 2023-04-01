# Use an official Dart runtime as a parent image
FROM google/dart AS dartbuilder

# Install necessary dependencies
RUN apt-get update && apt-get install -y git unzip wget curl

# Install Flutter
ENV FLUTTER_HOME=/usr/local/flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME \
  && $FLUTTER_HOME/bin/flutter precache \
  && $FLUTTER_HOME/bin/flutter config --enable-web \
  && $FLUTTER_HOME/bin/flutter doctor

# Add the Flutter binary directory to your path
ENV PATH=$PATH:$FLUTTER_HOME/bin

# Set the working directory to /app
WORKDIR /app

# Copy the entire Flutter project to the container
COPY . .

RUN flutter config --enable-web

RUN flutter devices

# Install project dependencies
RUN flutter pub get

# Build the Flutter web application
RUN flutter build web

FROM nginx:alpine

COPY --from=dartbuilder /app/build/web /usr/share/nginx/html