# Spark Connect Java Example

This project demonstrates how to use Spark Connect with Java. It provides a simple example of connecting to a Spark cluster using Spark Connect client.

## Prerequisites

### 1. Java 17 Installation

#### For macOS:
```bash
# Using Homebrew
brew install openjdk@17

# Verify installation
java -version
```

#### For Linux:
```bash
# Update package list
sudo apt update

# Install Java 17
sudo apt install openjdk-17-jdk

# Verify installation
java -version
```

### 2. Apache Spark 4.x Setup

1. Download Apache Spark 4.x from the official website
2. Extract it to your preferred location
3. Set up environment variables:

```bash
# Add these to your ~/.zshrc or ~/.bashrc
export SPARK_HOME=/path/to/your/spark
export PATH=$SPARK_HOME/bin:$PATH
```

4. Verify Spark installation:
```bash
spark-submit --version
```

## Building and Running the Project

This project uses Maven for dependency management and includes a convenient script to build and run the application. To build and run the project:

```bash
# Make the script executable (only needed once)
chmod +x build_run.sh

# Run the script
./build_run.sh
```

The script will:
1. Build the project using Maven
2. Run the application with all necessary Java options
3. Display build and execution status

## Troubleshooting

1. Make sure the `build_run.sh` script has executable permissions
2. Verify that `SPARK_HOME` is correctly set and points to your Spark installation directory
3. Make sure Spark services are running before executing the application
4. If you encounter any build issues, check that Maven is properly installed and configured

## License

Copyright 2024

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 