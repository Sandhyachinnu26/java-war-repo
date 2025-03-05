FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /ops-app

RUN git clone https://github.com/Rakesh-k-ops/java-war-repo.git .

RUN mvn clean package

FROM tomcat:10.1-jdk17

WORKDIR /usr/local/tomcat/webapps/

COPY --from=builder /ops-app/target/*.war opskill.war

EXPOSE 9000

CMD ["catalina.sh", "run"]
