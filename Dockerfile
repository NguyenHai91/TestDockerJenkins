# syntax=docker/dockerfile:experimental

# which official java image
FROM openjdk
# working directory
WORKDIR /app
#copy from your host(local) to container
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
# run this inside image
RUN ./mvnw dependency:go-offline
COPY src ./src
# run indise container
CMD [ "./mvnw", "spring-boot:run" ]
