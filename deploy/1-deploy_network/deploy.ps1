# ppbuak
# set current working directory
Set-Location -Path $PSScriptRoot

$resource_group_name = "vchds-sp-test-rg"

# Azure login; only need to login once per powershell session
# Login-AzureRmAccount

# $location = "canadacentral"
# New-AzureRmResourceGroup -Name $resource_group_name -Location $location

# # deploy resources declared in $template_path
# $template_path = "azuredeploy_vnet.json"
# $parameter_path = "azuredeploy_vnet.parameters.json"
# $deployment_name = "vnetDeployment"
# Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
# Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path -Verbose
# Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
# New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path -Verbose

# deploy resources declared in $template_path
$template_path = "azuredeploy_storage.json"
$parameter_path = "azuredeploy_storage.parameters.json"
$deployment_name = "storageDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path -Verbose
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path -Verbose


