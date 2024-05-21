FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone https://github.com/kmlhtpgl/blue_harvest.git
RUN cd blue_harvest && git checkout docker && mvn install
LABEL "Project"="blue-harvest"
LABEL "Author"="Kemal"
FROM tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE blue_harvest/target/react-and-spring-data-rest-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar

EXPOSE 8080