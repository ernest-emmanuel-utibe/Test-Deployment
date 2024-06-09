FROM maven:3.8.7 as build
COPY .. .
RUN mvn -B clean package -DskipTests

FROM openjdk:17-alpine
COPY --from=build /target/*.jar deploymentApp.jar

ENTRYPOINT ["java", "-jar", "-Dserver.port=8080", "deploymentApp.jar"]


## Use Maven to build the application
#FROM maven:3.8.7 AS build
#
## Set the working directory
#WORKDIR /app
#
## Copy the pom.xml file and download dependencies
#COPY pom.xml .
#RUN mvn dependency:go-offline -B
#
## Copy the rest of the application code
#COPY deploymentApp/src ./src
#
## Build the application
#RUN mvn -B clean package -DskipTests
#
## Use OpenJDK to run the application
#FROM openjdk:17-alpine
#
## Copy the built jar file from the Maven build stage
#COPY --from=build /app/target/*.jar deploymentApp.jar
#
## Expose the application port
#EXPOSE 8080
#
## Run the application
#ENTRYPOINT ["java", "-jar", "-Dserver.port=8080", "deploymentApp.jar"]
