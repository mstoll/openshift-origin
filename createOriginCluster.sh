# https://github.com/Microsoft/openshift-origin

rg="mdp-origin"
networkRg="MDP_-_Data_Hub_PoC"
location="WestEurope"
vnetname="mdp-origin-net"
masterSubnetName="masterSubnet"
nodeSubnetName="nodeSubnet"
vnetCidr="10.0.0.0/16"
masterSubenetCidr="10.0.0.0/24"
nodeSubnetCidr="10.0.1.0/24"


az group create -n "$networkRg" -l WestEurope

echo "Create a VNET to deploy K8s into an existing VNET"
 az network vnet create \
--name $vnetName \
--resource-group $networkRg \
--location westeurope \
--address-prefix $vnetCidr \
--subnet-name $subnetName \
--subnet-prefix $subnetCidr



echo "Create the resource group"
az group create -n "$rg" -l WestEurope


echo "Create the K8s by deploying the generated ARM template"
az group deployment create \
    --name "Fuckit" \
    --resource-group "$rg" \
    --template-file "azuredeploy.json" \
    --parameters "./azuredeploy.parameters.json"



ssh-agent bash -c 'ssh-add ~/.ssh/id_rsa; git push orgin master'




