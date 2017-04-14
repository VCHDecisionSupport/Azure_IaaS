Set-Location -Path $PSScriptRoot
$template_path = Join-Path -Path $PSScriptRoot -ChildPath "azuredeploy.json"
$template_path = "azuredeploy.json"
# $template_path = "azuredeploy_subnets.json"
# $parameter_path = "azuredeploy.parameters.json"
$resource_group_name = "testvchrg"

# Login-AzureRmAccount

New-AzureRmResourceGroup -Name $resource_group_name -Location "canadacentral"

Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path

New-AzureRmResourceGroupDeployment -Name gcdeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path
