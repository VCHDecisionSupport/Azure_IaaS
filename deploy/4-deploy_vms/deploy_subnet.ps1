# https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm
# https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-dynamic-data-disks-selection/azuredeploy.json

# set current working directory
Set-Location -Path $PSScriptRoot
$resource_group_name = "vchds-sp-test-rg"
$location = "canadacentral"

# Azure login; only need to login once per powershell session
# Login-AzureRmAccount

# deploy resources declared in $template_path
$template_path = "azuredeploy_subnet.json"
$parameter_path = "azuredeploy_subnet.parameters.json"
$deployment_name = "subnetDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
