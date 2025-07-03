# Stage 1: Builder - Compile and package the application
FROM maven:3.8.6-openjdk-11 AS builder

WORKDIR /app

# Copy POM files first for dependency caching
COPY pom.xml .
COPY server/pom.xml ./server/
COPY webapp/pom.xml ./webapp/

# Download dependencies
RUN mvn dependency:go-offline -B

# Copy source files
COPY . .

# Build the application (skip tests for Docker build)
RUN mvn clean package -DskipTests

# Stage 2: Runtime - Deploy to Tomcat
FROM tomcat:9.0-jre11-openjdk-slim

# Clean default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file
COPY --from=builder /app/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Set permissions
RUN chmod -R 755 /usr/local/tomcat

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1

CMD ["catalina.sh", "run"]