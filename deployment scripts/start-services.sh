#!/bin/bash
RESOURCE_GROUP="rg-stage24-webchefs"
WEB_APP="culinarycode"
KEYCLOAK_APP="culinarycode-idp"
POSTGRES_SERVER="culinarycode-database"
CONTAINER_INSTANCE="culinarycode-idp"

# Function to wait until a condition is met
wait_until_ready() {
  local command="$1"
  local expected_status="$2"
  local service_name="$3"

  echo "Waiting for $service_name to be ready..."
  while true; do
    current_status=$(eval "$command" | xargs | tr -d '\r')
    if [ "$current_status" == "$expected_status" ]; then
      echo "$service_name is ready!"
      break
    fi
	echo "Current status: [$current_status]"
    echo "Expected status: [$expected_status]"
    echo "$service_name is not ready yet... checking again in 10 seconds."
    sleep 10
  done
}

# Start PostgreSQL Flexible Server
echo "Starting PostgreSQL Flexible Server: $POSTGRES_SERVER"
az postgres flexible-server start --name $POSTGRES_SERVER --resource-group $RESOURCE_GROUP
wait_until_ready "az postgres flexible-server show --name $POSTGRES_SERVER --resource-group $RESOURCE_GROUP --query 'state' -o tsv" "Ready" "PostgreSQL Flexible Server"

# Start Container Instance
echo "Starting Container Instance: $CONTAINER_INSTANCE"
az container start --name $CONTAINER_INSTANCE --resource-group $RESOURCE_GROUP
wait_until_ready "az container show --name $CONTAINER_INSTANCE --resource-group $RESOURCE_GROUP --query 'instanceView.state' -o tsv" "Running" "Container Instance"

# Start Keycloak Web App
echo "Starting Web App: $KEYCLOAK_APP"
az webapp start --name $KEYCLOAK_APP --resource-group $RESOURCE_GROUP
wait_until_ready "az webapp show --name $KEYCLOAK_APP --resource-group $RESOURCE_GROUP --query 'state' -o tsv" "Running" "Keycloak Web App"

# Start Web App
echo "Starting Web App: $WEB_APP"
az webapp start --name $WEB_APP --resource-group $RESOURCE_GROUP
wait_until_ready "az webapp show --name $WEB_APP --resource-group $RESOURCE_GROUP --query 'state' -o tsv" "Running" "Web App"

echo "All services are now running!"
