# This Dockerfile builds a simple Maven application and packages it into a Docker image.

# Stage 1: Build the application using a Maven base image.
# We're updating the Maven version here to 3.9.9 to satisfy the enforcer plugin
# version requirement from the project's pom.xml.
FROM maven:3.9.9-eclipse-temurin-21 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Build the application with Maven. This will compile, run tests, and package the JAR.
RUN mvn clean package

# Stage 2: Create a smaller, final image for the runtime environment.
# Using a slim JRE image to reduce the final image size.
FROM eclipse-temurin:21-jre-alpine

# Set the working directory for the final image.
WORKDIR /app

# Copy the built JAR file from the build stage into the final image.
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar ./app.jar

# Define the entrypoint for the application.
# This command runs the JAR file when the container starts.
ENTRYPOINT ["java", "-jar", "app.jar"]
