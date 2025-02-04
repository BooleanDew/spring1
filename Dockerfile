# Etapa de construcción (Maven)
FROM maven:3.8-jdk-17 AS builder 
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa de ejecución (Entorno de ejecución)
FROM amazoncorretto:17-alpine-jdk
WORKDIR /app
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar ./app.jar
ENTRYPOINT ["java","-jar","/app.jar"]