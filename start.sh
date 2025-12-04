#!/usr/bin/env bash
# PUBLIC_INTERFACE
# start.sh - Entry script to start the Spring Boot application from the repository root.
# This script prefers the Maven Wrapper (./mvnw) if present; otherwise falls back to system mvn.
# It also sets standard environment variables for the preview system.
#
# Behavior:
# - Exposes the server on 0.0.0.0:3002 by default
# - Uses Maven to run the Spring Boot app (spring-boot:run)
# - Does not cd into any nested directory; assumes pom.xml is in the same directory or Maven can resolve modules.
#
# Environment:
# - SERVER_PORT: Override server.port (default 3002)
# - SERVER_ADDRESS: Override server.address (default 0.0.0.0)
#
# Note:
# - If your project is a multi-module Maven build, spring-boot:run should be configured in the correct module's pom.
# - If you need a different module, adjust the -pl <module> and -am options accordingly.

set -euo pipefail

# Defaults for preview
export SERVER_PORT="${SERVER_PORT:-3002}"
export SERVER_ADDRESS="${SERVER_ADDRESS:-0.0.0.0}"

# Build JVM system properties from environment for Spring Boot
SPRING_PROPS=(
  "-Dserver.port=${SERVER_PORT}"
  "-Dserver.address=${SERVER_ADDRESS}"
)

# Prefer Maven Wrapper if present
MVN_CMD=""
if [ -x "./mvnw" ]; then
  MVN_CMD="./mvnw"
elif [ -x "mvnw" ]; then
  MVN_CMD="mvnw"
else
  MVN_CMD="mvn"
fi

# Echo for diagnostics
echo "Using Maven command: ${MVN_CMD}"
echo "Starting Spring Boot with: ${SPRING_PROPS[*]}"

# Run the Spring Boot application. 
# -DskipTests=true speeds up startup in preview environments; adjust if needed.
exec ${MVN_CMD} -DskipTests=true ${SPRING_PROPS[@]} spring-boot:run
