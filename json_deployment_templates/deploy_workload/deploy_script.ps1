Set-Location -Path $PSScriptRoot
$resource_group_name = "testrg"
$template_path = "script_extension.json"

New-AzureRmResourceGroupDeployment -Name sharedResourcesDeployment1 -ResourceGroupName $resource_group_name -TemplateFile $template_path