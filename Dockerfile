# Stage 1: The Build Stage
# Use a Maven image that includes JDK 21 to satisfy the enforcer plugin rule.
FROM maven:3.9.8-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: The Final Runtime Stage
# Use a lightweight JRE 21 image to run the final application.
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /app.jar
CMD ["java", "-jar", "/app.jar"]
