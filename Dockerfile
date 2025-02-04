FROM eclipse-temurin:17-jre-alpine AS build
WORKDIR /app
COPY demo/pom.xml ./
RUN mvn dependency:go-offline
COPY demo/src ./src
COPY demo/.mvn ./mvn
RUN mvn clean package -f demo/pom.xml

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar ./
CMD ["java", "-jar", "*.jar"]
EXPOSE 8080