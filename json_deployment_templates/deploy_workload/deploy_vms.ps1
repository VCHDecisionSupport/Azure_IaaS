# https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm
# https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-dynamic-data-disks-selection/azuredeploy.json

# set current working directory
Set-Location -Path $PSScriptRoot
$resource_group_name = "configrg"
$location = "canadacentral"

# Azure login; only need to login once per powershell session
# Login-AzureRmAccount

# deploy resources declared in $template_path
$template_path = "azuredeploy_vms.json"
$parameter_path = "azuredeploy_vms.parameters.json"
$deployment_name = "vmDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
