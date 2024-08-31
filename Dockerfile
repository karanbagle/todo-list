# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the working directory
COPY . .

# Package the application
RUN ./mvnw clean install

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["./mvnw", "spring-boot:run"]
