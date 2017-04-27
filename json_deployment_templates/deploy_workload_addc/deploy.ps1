Set-Location -Path $PSScriptRoot
$resource_group_name = "addcvchds"
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$location = "canadacentral"
$deployment_name = "addcDeployment"


Login-AzureRmAccount

New-AzureRmResourceGroup -Name $resource_group_name -Location $location

New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path