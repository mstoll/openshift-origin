# Keyvault Secrets 
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-keyvault-parameter

# https://github.com/Microsoft/openshift-origin

rg="mdp-origin"
networkRg="MDP_-_Data_Hub_PoC"
location="WestEurope"
<<<<<<< HEAD
vnetName="mdp-poc-network"
masterSubnetName="mdp-poc-network"
#nodeSubnetName="nodeSubnet"
vnetCidr="10.79.77.0/24"
masterSubenetCidr="10.79.77.0/24"
=======
vnetName="mdp-origin-net"
masterSubnetName="masterSubnet"
nodeSubnetName="nodeSubnet"
vnetCidr="10.0.0.0/16"
masterSubenetCidr="10.0.0.0/24"
>>>>>>> c91cf7b8392ae52420fbfa5b7f7022a6bc1db5fd
#nodeSubnetCidr="10.0.1.0/24"
keyVaultname="mdp-keyvault"
secretName="sshPrivateKey"

<<<<<<< HEAD
# az group create -n "$networkRg" -l WestEurope

# echo "Create a VNET to deploy K8s into an existing VNET"
#  az network vnet create \
# --name $vnetName \
# --resource-group $networkRg \
# --location westeurope \
# --address-prefix $vnetCidr \
# --subnet-name $masterSubnetName \
# --subnet-prefix $masterSubenetCidr
=======
##
##
##
az group create -n "$networkRg" -l WestEurope

echo "Create a VNET to deploy K8s into an existing VNET"
 az network vnet create \
--name $vnetName \
--resource-group $networkRg \
--location westeurope \
--address-prefix $vnetCidr \
--subnet-name $nodeSubnetName \
--subnet-prefix $masterSubenetCidr
>>>>>>> c91cf7b8392ae52420fbfa5b7f7022a6bc1db5fd

##
##
##
echo "Create the resource group"
az group create -n "$rg" -l $location

az keyvault create -n $keyVaultname -g $rg -l $location --enabled-for-template-deployment true
az keyvault secret set --vault-name $keyVaultname -n $secretName --file ~/.ssh/id_rsa

# az group deployment validate --resource-group "$rg" --template-file "azuredeploy.json" --parameters "./azuredeploy.parameters.json"

echo "Create the K8s by deploying the generated ARM template"
az group deployment create --debug --name "mdp-deployment1" --resource-group "$rg" --template-file "azuredeploy.json" --parameters "./azuredeploy.parameters.json" | tee openshift.log


#az group deployment create --debug --name "mdp-deployment1" --resource-group "test" --template-file "hack-azuredeploy.json" --parameters "./azuredeploy.parameters.json" | tee openshift.log

# az group delete -y --name $rg

