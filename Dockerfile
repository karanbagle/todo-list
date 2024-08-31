FROM openjdk:17-jdk-alpine 
# Use the OpenJDK 17 runtime with Alpine Linux as the base image.

COPY target/todo-list-0.0.1-SNAPSHOT.jar app.jar
# Copy the built JAR file from the target directory in your local machine into the container and rename it to app.jar.

ENTRYPOINT ["java","-jar","/app.jar"]
# This command tells the container to run the JAR file using the Java runtime when the container starts.
