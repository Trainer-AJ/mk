# Variables (replace these with your actual values)
RESOURCE_GROUP="test"
LOCATION="centralindia"
VNET_NAME="app-srv"
SUBNET_NAME="pipeline-agent"
CONTAINER_GROUP_NAME="my-cli-agent"
CONTAINER_IMAGE="oj09/azp-ubuntu-2204:latest"  # Your Azure DevOps agent container image
CPU_CORES=1
MEMORY_GB=2

# Azure DevOps environment variables
AZP_TOKEN="3xxxxxxxxxxxxxxxxxxxxxxxxxxx3Ajx"
AZP_POOL="test"
AZP_NAME="cli"

# Get subnet resource ID (required for ACI deployment in VNet)
SUBNET_ID=$(az network vnet subnet show \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --query id -o tsv)

echo "Using subnet ID: $SUBNET_ID"

# Create container instance in the subnet with environment variables
az container create \
  --resource-group $RESOURCE_GROUP \
  --name $CONTAINER_GROUP_NAME \
  --image $CONTAINER_IMAGE \
  --os-type Linux \
  --cpu $CPU_CORES \
  --memory $MEMORY_GB \
  --vnet $VNET_NAME \
  --subnet $SUBNET_NAME \
  --location $LOCATION \
  --environment-variables AZP_TOKEN=$AZP_TOKEN AZP_POOL=$AZP_POOL AZP_NAME=$AZP_NAME \
  --restart-policy OnFailure \
  --output table
