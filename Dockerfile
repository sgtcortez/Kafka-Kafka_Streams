FROM openjdk:11
COPY ./build/libs/App.jar app.jar
CMD ["java", "-jar", "/app.jar"]
