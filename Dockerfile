FROM openjdk:8-jdk-alpine

VOLUME /tmp

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} /app.jar

COPY . .

ENTRYPOINT ["java","-jar","/app.jar"]