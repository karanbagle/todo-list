# Use a base image with Maven and a specific JDK version installed
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install

# Use a smaller JDK image for the runtime
FROM openjdk:17-jdk-alpine
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
