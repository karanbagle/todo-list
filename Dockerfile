FROM eclipse-temurin:17-jdk-alpine as build

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw .
COPY pom.xml .
RUN ./mvnw dependency:go-offline

COPY src ./src
RUN ./mvnw package -DskipTests

FROM eclipse-temurin:17-jdk-alpine

VOLUME /tmp

ARG JAR_FILE=target/*.jar
COPY --from=build /app/${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
