#!/bin/bash
# Script to stop Azure services in the specified resource group

# Set resource group name
RESOURCE_GROUP="rg-stage24-webchefs"

# Service names
WEB_APP="culinarycode"
POSTGRES_SERVER="culinarycode-database"
CONTAINER_INSTANCE="culinarycode-idp"

# Stop Web App
echo "Stopping Web App: $WEB_APP"
az webapp stop --name $WEB_APP --resource-group $RESOURCE_GROUP

# Stop PostgreSQL Flexible Server
echo "Stopping PostgreSQL Flexible Server: $POSTGRES_SERVER"
az postgres flexible-server stop --name $POSTGRES_SERVER --resource-group $RESOURCE_GROUP

# Stop Container Instance
echo "Stopping Container Instance: $CONTAINER_INSTANCE"
az container stop --name $CONTAINER_INSTANCE --resource-group $RESOURCE_GROUP

echo "All specified services have been stopped."
