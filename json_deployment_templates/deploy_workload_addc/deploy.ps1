Set-Location -Path $PSScriptRoot
$resource_group_name = "fromdsrepo"
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$location = "canadacentral"
$deployment_name = "addcDeploymentfromdsrepo"


Login-AzureRmAccount

New-AzureRmResourceGroup -Name $resource_group_name -Location $location

New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path