# The `maven-enforcer-plugin` in the project's pom.xml requires Maven version 3.9.9 or later.
# This Dockerfile is updated to use a base image that meets that requirement.
# Using a specific version (3.9.9) instead of `latest` ensures a consistent and reproducible build environment.
FROM maven:3.9.9-jdk-17

# The working directory for the application inside the Docker container.
WORKDIR /app

# Copy the project's pom.xml file to the container.
# This is a best practice to leverage Docker's build cache.
COPY pom.xml .

# Copy the source code to the container.
COPY src ./src

# Build the application.
# The `mvn clean install` command runs the build and tests.
RUN mvn clean install

# The final image will expose the application, which runs on a specific port.
# The port is defined by the application's configuration.
EXPOSE 8080

# The command to run the application when the container starts.
# It executes the generated .jar file.
CMD ["java", "-jar", "target/simple-java-maven-app-1.0.jar"]
