# Stage 1: The Build Stage
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn -B -DskipTests clean package

# Stage 2: The Final Runtime Stage
# Use a lightweight runtime image with a JDK 21 JRE for the final app.
FROM eclipse-temurin:21-jre-focal
WORKDIR /app
COPY --from=build /app/target/simple-java-maven-app-1.0-SNAPSHOT.jar /app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
