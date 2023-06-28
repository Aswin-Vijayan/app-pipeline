FROM openjdk:17
EXPOSE 8080
WORKDIR /app/
COPY petclinic/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar", "&"]