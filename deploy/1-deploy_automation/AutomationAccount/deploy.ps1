Set-Location -Path $PSScriptRoot
$resource_group_name = "vchds-auto-rg"

# Login-AzureRmAccount

# deploy resources declared in $template_path
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$deployment_name = "autoAccountDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
