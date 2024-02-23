# Use the official OpenJDK image as base image
FROM openjdk:22-ea-17-jdk-slim-bullseye

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/cicd-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port that your Spring Boot application will run on
EXPOSE 8080

# Specify the command to run your application
CMD ["java", "-jar", "app.jar"]