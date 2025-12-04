#!/usr/bin/env bash
# PUBLIC_INTERFACE
# start.sh - Entry script to start the Spring Boot application from the repository root.
# This script uses the Maven Wrapper (./mvnw) and never relies on a system 'mvn'.
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

# Ensure Maven Wrapper exists and is executable
if [ ! -f "./mvnw" ]; then
  echo "ERROR: ./mvnw not found at repository root. Please add Maven Wrapper (mvn -N io.takari:maven:wrapper or mvn -N -q -Ddistrib ..) and commit .mvn and mvnw."
  echo "The preview system is configured to use ./mvnw only."
  exit 1
fi

# Fix permissions if needed
if [ ! -x "./mvnw" ]; then
  chmod +x ./mvnw || true
fi

echo "Using Maven Wrapper: ./mvnw"
echo "Starting Spring Boot with: ${SPRING_PROPS[*]}"

# Run the Spring Boot application quietly, skipping tests to speed up preview boot.
exec ./mvnw -q -DskipTests=true "${SPRING_PROPS[@]}" spring-boot:run
