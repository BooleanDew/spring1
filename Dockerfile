# Usar una imagen base de Java adecuada.  Considera usar una imagen slim para reducir el tamaño.
FROM openjdk:17-jdk-slim

# Establecer el directorio de trabajo dentro del contenedor.
WORKDIR /app

# Copiar el archivo pom.xml para que Maven pueda resolver las dependencias.
COPY demo/pom.xml ./

# Instalar las dependencias de Maven.  Esto se hace antes de copiar el resto del código fuente para optimizar la construcción.
RUN mvn dependency:go-offline

# Copiar el resto del código fuente.
COPY demo/src ./src
COPY demo/.mvn ./mvn

# Construir la aplicación Spring Boot.
RUN mvn clean package -f demo/pom.xml

# Establecer el punto de entrada de la aplicación.
CMD ["java", "-jar", "target/*.jar"]

# Exponer el puerto correcto. Por defecto, Spring Boot usa el 8080.
EXPOSE 8080