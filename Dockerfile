# Stage 1: build jar bằng Maven
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copy toàn bộ project vào container build
COPY . .

# Build jar, bỏ qua test cho nhanh
RUN ./mvnw -DskipTests=true package

# Stage 2: runtime image
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy file jar đã build từ stage 1
COPY --from=build /app/target/*.jar app.jar

# Không set profile gì thêm, dùng H2 từ application.properties
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
