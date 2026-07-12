## Spring Boot REST API Deployment using Docker

## Overview

This project demonstrates deploying a Spring Boot REST API application using Docker.

Deployment flow:
Spring Boot Source Code
|
|
Maven Build
|
|
Executable JAR
|
|
Docker Image
|
|
Docker Container
|
|
Port 8080
|
|
Browser / Postman


---

# Technology Stack

- Java 17
- Spring Boot 3.x
- Maven
- Docker

---

# Project Structure

---

# Technology Stack

- Java 17
- Spring Boot 3.x
- Maven
- Docker

---

# Project Structure
springboot-docker/
├── src/
│
├── pom.xml
│
├── Dockerfile
│
└── README.md



---

# Step 1: Create Spring Boot Project

Go to:

---
https://start.spring.io

Select:
Project : Maven
Language : Java
Java Version : 17
Packaging : Jar

Dependencies:
Spring Web
Spring Boot Actuator


Download and extract.

---

# Step 2: Create REST API

Create:

Download and extract.

---

# Step 2: Create REST API

Create:

Download and extract.

---

# Step 2: Create REST API

Create:
HelloController.java

Location:
src/main/java/com/example/demo/


Code:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.*;

@RestController
public class HelloController {

    @GetMapping("/api/hello")
    public String hello(){

        return "Hello from Spring Boot";

    }

}


Step 3: Run Application Locally
Start:
Linux/Mac:
./mvnw spring-boot:run
Windows:
mvnw.cmd spring-boot:run
Test:
Test:
http://localhost:8080/api/hello
Response:
Hello from Spring Boot
Health:
http://localhost:8080/actuator/health
Response:
{
 "status":"UP"
}


Step 4: Build Application
Stop application:
CTRL + C
Build:
./mvnw clean package
Output:
target/application.jar


Step 5: Create Dockerfile
Create:
Dockerfile
Content:
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT [
"java",
"-jar",
"app.jar"
]

Step 6: Build Docker Image
docker build -t springboot-demo:v1 .
Check:
docker images


Step 7: Run Container
docker run -d \
--name springboot-container \
-p 8080:8080 \
springboot-demo:v1


Step 8: Test Container
Browser:
http://localhost:8080/api/hello
Curl:
curl localhost:8080/api/hello

