FROM maven:3.8.1-jdk-17 AS build
WORKDIR /app
COPY demo/pom.xml ./
RUN mvn dependency:go-offline
COPY demo/src ./src
COPY demo/.mvn ./mvn
RUN mvn clean package -f demo/pom.xml

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar ./
CMD ["java", "-jar", "*.jar"]
EXPOSE 8080