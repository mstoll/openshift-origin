# https://github.com/Microsoft/openshift-origin

rg="mdp-origin"

echo "Create the resource group"
az group create -n "$rg" -l WestEurope


echo "Create the K8s by deploying the generated ARM template"
az group deployment validate \
    --resource-group "$rg" \
    --template-file "azuredeploy.json" \
    --parameters "./azuredeploy.parameters.json"



ssh-agent bash -c 'ssh-add ~/.ssh/id_rsa; git push orgin master'




