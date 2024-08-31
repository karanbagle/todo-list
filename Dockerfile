# Step 1: Use a Maven image to build the application
FROM maven:3.8.6-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Step 2: Use the OpenJDK image to run the application
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/todo-list-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
