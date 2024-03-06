# Read Me First
The following was discovered as part of building this project:

* The original package name 'com.hainguyen.demo-docker' is invalid and this project uses 'com.hainguyen.demodocker' instead.

# Getting Started

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/3.2.3/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/3.2.3/maven-plugin/reference/html/#build-image)

Build your springboot with maven wrapper:
./mvnw spring-boot:run
This downloads the dependencies, build the project and start it

How can we run this project on docker?
- Build your own image with docker image:
docker build --tag demo-docker:v1.0.0 .

- To create a new tag for the image we've built above:
docker tag demo-docker:latest demo-docker:v1.0.0

- Push your own image to docker hub:
docker push demo-docker:v1.0.0
- Create a network
docker network create springboot-mysql-network

- Start/run a container, notes(for cmd '%cd%' for powershell, terminal '$(pwd)'):
docker run -dp 3000:3000 --name demo-docker -v "%cd%:/app" --network springboot-mysql-network demo-docker:v1.0.0
  
- Run a mysqldb container:
docker run --name mysqldb -v mysql-data:/var/lib/mysql -v mysql-config-deamond:/etc/mysql/conf.d -p 3306:3306 --network springboot-mysql-network -e MYSQL_ROOT_PASSWORD=789789 -e MYSQL_DATABASE=demo-docker -d mysql:8.0.28

- Access to mysql:
docker exec -it mysqldb mysql -u root -p

Now write all step above in a file docker-compose, then run it:
docker-compose -f docker-compose.dev.yml up --build

- Remove container:
docker rm -f container1 container2

- Start/stop/restart a container:
docker start/stop/restart container
  
- run jenkins:
docker run --name jenkins -p 3007:3007 -p 3009:3009 -v jenkins:/var/jenkins_home jenkins/jenkins:lts

docker run -d --name myjenkins -p 8080:8080 -p 50000:50000 -v jenkins:/var/jenkins_home jenkins/jenkins

docker run --name myjenkins --restart=on-failure ^
--network jenkins --env DOCKER_HOST=tcp://docker:2376 ^
--env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 ^
--volume jenkins-data:/var/jenkins_home ^
--volume jenkins-docker-certs:/certs/client:ro ^
--publish 8080:8080 --publish 50000:50000 myjenkins-blueocean:2.440.1-1