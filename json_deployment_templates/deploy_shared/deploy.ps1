# https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm
# https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-dynamic-data-disks-selection/azuredeploy.json
# https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-dynamic-data-disks-selection/azuredeploy.json

# set current working directory
Set-Location -Path $PSScriptRoot
$resource_group_name = "configrg"
$location = "canadacentral"

# Azure login; only need to login once per powershell session
# Login-AzureRmAccount

# # create new resource group
# New-AzureRmResourceGroup -Name $resource_group_name -Location $location

# # deploy resources declared in $template_path
$template_path = "azuredeploy_vnet.json"
$parameter_path = "azuredeploy_vnet.parameter.json"
New-AzureRmResourceGroupDeployment -Name storageDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path


$template_path = "azuredeploy_storage.json"
$parameter_path = "azuredeploy_storage.parameters.json"
New-AzureRmResourceGroupDeployment -Name vnetDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path


