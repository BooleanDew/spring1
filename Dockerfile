# Etapa de construcción
FROM maven:3.8.4-openjdk-17-slim AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de configuración de Maven
COPY pom.xml .
COPY src ./src

# Construye la aplicación sin ejecutar tests
RUN mvn clean package -DskipTests

# Etapa final
FROM openjdk:17-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el JAR generado desde la etapa de construcción
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

# Expone el puerto que usará tu aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación usando JAVA_OPTS
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/demo.jar"]