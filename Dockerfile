FROM maven:3.8.7 as build
COPY . .
RUN mvn clean package

FROM openjdk:17
COPY --from=build /target/*.jar deploymentApp.jar

ENTRYPOINT ["java", "-jar", "-Dserver.port=8080", "deploymentApp.jar"]
