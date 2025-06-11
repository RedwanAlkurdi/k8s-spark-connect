#!/bin/bash

set -e  # Exit on any error

# Set Java options for Spark Connect
JAVA_OPTS="--add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/sun.nio.ch=ALL-UNNAMED \
    -Djavax.net.ssl.trustStore=../EDP_CA/nzero-truststore.jks \
    -Djavax.net.ssl.trustStoreType=JKS \
    -Djavax.net.ssl.trustStorePassword=changeit"

# Path to the jar with dependencies
JAR_PATH="$(pwd)/target/spark-connect-java-test-1.0-SNAPSHOT-jar-with-dependencies.jar"

# Display info
echo "============================================="
echo "Building Spark Connect Java Application..."
echo "============================================="

# Build the project using Maven
mvn clean package

# Check if build was successful
if [ $? -eq 0 ]; then
    echo
    echo "============================================="
    echo "Running the application..."
    echo "============================================="
    echo
    
    # Run the application
    java $JAVA_OPTS -jar $JAR_PATH
    
    # Add a small delay at the end to ensure all cleanup processes complete
    sleep 2
    
    echo
    echo "============================================="
    echo "Application completed successfully!"
    echo "============================================="
else
    echo
    echo "============================================="
    echo "Build failed! Please check the error messages above."
    echo "============================================="
    exit 1
fi

