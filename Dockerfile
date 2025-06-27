# Stage 1: Builder - Compile and package the application
FROM maven:3.8.6-openjdk-11 AS builder

WORKDIR /app

# 1. Copy only the POM files first (for better layer caching)
COPY pom.xml .
COPY server/pom.xml ./server/
COPY webapp/pom.xml ./webapp/

# 2. Download all dependencies (offline mode)
RUN mvn dependency:go-offline -B

# 3. Copy actual source files
COPY server/src ./server/src
COPY webapp/src ./webapp/src

# 4. Build the application with debug output
RUN mvn clean package -X

# 5. Verify the build output
RUN ls -l /app/server/target/ && ls -l /app/webapp/target/

# Stage 2: Runtime - Deploy to Tomcat
FROM tomcat:9.0.95-jre11-openjdk-slim AS runtime

# 1. Clean default Tomcat apps (security best practice)
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copy the built WAR file from builder stage
COPY --from=builder /app/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

# 3. Set proper permissions
RUN chmod -R 755 /usr/local/tomcat

# 4. Expose port
EXPOSE 8080

# 5. Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1

# 6. Start command
CMD ["catalina.sh", "run"]