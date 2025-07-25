#!/bin/bash

# Usage: ./deploy.sh <stage> <service_repo_url>
# Example: ./deploy.sh dev https://github.com/Trainings-TechEazy/test-repo-for-devops.git

STAGE=$1
REPO_URL=$2

if [ -z "$STAGE" ] || [ -z "$REPO_URL" ]; then
  echo "❌ Usage: ./deploy.sh <dev|prod> <repo_url>"
  exit 1
fi

# Cleanup any old repo
rm -rf temp-service

# Clone the service repo
echo "📥 Cloning service repository..."
git clone "$REPO_URL" temp-service
cd temp-service || exit 1

# Build the application
echo "⚙️ Building service using Maven..."
./mvnw clean package -DskipTests

# Decide which config file to copy
if [ "$STAGE" == "dev" ]; then
    CONFIG_FILE="src/main/resources/dev_config.properties"
elif [ "$STAGE" == "prod" ]; then
    CONFIG_FILE="src/main/resources/prod_config.properties"
else
    echo "❌ Invalid stage. Use 'dev' or 'prod'."
    exit 1
fi

# Apply config
echo "🔧 Applying $STAGE configuration..."
cp "$CONFIG_FILE" src/main/resources/application.properties

# Rebuild after applying config
echo "🔁 Rebuilding with applied config..."
./mvnw clean package -DskipTests

# Stop app if already running
echo "🛑 Stopping any running app on port 80..."
sudo fuser -k 80/tcp || true

# Run the app
echo "🚀 Starting the app on port 80..."
sudo java -jar target/*.jar &

echo "✅ Deployed $STAGE environment successfully."
