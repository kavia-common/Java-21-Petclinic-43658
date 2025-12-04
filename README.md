# Java-21-Petclinic

Startup
-------

This container includes a root-level start.sh and Procfile so preview systems start the application from the repository root without any `cd`.

- Start locally:
  - `bash ./start.sh`
- Env overrides (optional):
  - `SERVER_PORT` (default: 3002)
  - `SERVER_ADDRESS` (default: 0.0.0.0)

Important:
- The startup uses the Maven Wrapper (`./mvnw`) exclusively and never relies on a system `mvn`.
- Ensure `./mvnw` exists and is executable (the script will chmod +x if needed).
- Procfile runs: `env SERVER_PORT=3002 SERVER_ADDRESS=0.0.0.0 ./mvnw -q spring-boot:run`.

The script passes the server port and address via JVM system properties for Spring Boot.
