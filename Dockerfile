# Stage 1: Build the application with Maven
FROM maven:3.8.5-openjdk-17 AS builder

# Set environment variables for Java
ENV JAVA_HOME=/usr/java/openjdk-17
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Set working directory
WORKDIR /app

# Copy project files into the container
COPY . .

# Ensure Maven Wrapper script is executable
# RUN chmod +x ./mvnw


# Build the project with Maven Wrapper
RUN mvn clean install -DskipTests 

# Stage 2: Deploy the application to Tomcat
FROM tomcat:9.0-jdk17-openjdk

# Set JAVA_HOME for the runtime stage
ENV JAVA_HOME=/usr/local/openjdk-17
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build stage into Tomcat's webapps directory
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/jpetstore.war

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
