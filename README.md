# Java-21-Petclinic

Startup
-------

This container includes a root-level start.sh and Procfile to help preview systems start the application without changing directories.

- Start locally:
  - `bash ./start.sh`
- Env overrides (optional):
  - `SERVER_PORT` (default: 3002)
  - `SERVER_ADDRESS` (default: 0.0.0.0)

The script prefers the Maven Wrapper (`./mvnw`) if present and falls back to `mvn`. It passes the server port and address via JVM system properties for Spring Boot.
