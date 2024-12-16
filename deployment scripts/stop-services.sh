#!/bin/bash
# Script to stop Azure services in the specified resource group

# Set resource group name
RESOURCE_GROUP="rg-stage24-webchefs"

# Service names
WEB_APP="culinarycode"
KEYCLOAK_APP="culinarycode-idp"
POSTGRES_SERVER="culinarycode-database"

# Stop Web App
echo "Stopping Web App: $WEB_APP"
az webapp stop --name $WEB_APP --resource-group $RESOURCE_GROUP

# Stop Keycloak Web App
echo "Stopping Keycloak Web App: $KEYCLOAK_APP"
az webapp stop --name $KEYCLOAK_APP --resource-group $RESOURCE_GROUP

# Stop PostgreSQL Flexible Server
echo "Stopping PostgreSQL Flexible Server: $POSTGRES_SERVER"
az postgres flexible-server stop --name $POSTGRES_SERVER --resource-group $RESOURCE_GROUP

echo "All specified services have been stopped."
