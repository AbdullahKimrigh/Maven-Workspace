FROM openjdk:11-jdk-alpine

ARG JAR_FILE=LearningMaven/target/*.jar

COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]

EXPOSE 80