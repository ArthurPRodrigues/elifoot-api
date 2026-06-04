FROM maven:3.9-amazoncorretto-17 AS builder
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM amazoncorretto:17-alpine
WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

USER spring:spring

ENTRYPOINT ["java", "-jar", "app.jar"]
