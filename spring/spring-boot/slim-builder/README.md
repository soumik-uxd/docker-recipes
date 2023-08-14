

# Slim Temurin Builder for spring-boot-hello
This a demonstration of usage of slim versions of [OpenJDK](https://hub.docker.com/_/openjdk)  and [Debian](https://hub.docker.com/_/debian) images to create a multisatge build for a sample spring boot API which returns a simple greeting, using [jlink](https://docs.oracle.com/en/java/javase/11/tools/jlink.html#GUID-CECAC52B-CFEE-46CB-8166-F17A8E9280E9).

Before the application can be started the following checks need to be done:

#### 1. Clone the application
Clone the repository
```bash
git clone <repo>
```
#### 2. Build the application locally (optional)
For a local build, we need to first install the dependencies
```bash
./mvnw clean install
```
Then we build the packages
```bash
./mvnw -V -B -DskipTests clean package verify
```
#### 3. Run the application locally (optional)
```bash
./mvnw spring-boot:run
```
Once done the endpoint is available at `http:\\localhost:8080`
```bash
curl -X GET  'http://localhost:8080'
```
The response would be a `text/plain;charset=UTF-8` encoded string, which says:
```text
Greetings from Spring Boot!
```

#### 4. Build the image
```bash
docker build -t <IMAGE_NAME> .
```
#### 5. Run the application 
```bash
docker run -d --rm --name spring-boot-hello -p 8080:8080 <IMAGE_NAME>
```
