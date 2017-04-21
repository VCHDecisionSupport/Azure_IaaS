# https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm

# set current working directory
Set-Location -Path $PSScriptRoot
$template_path = "azuredeploy.json"
# $template_path = "azuredeploy_subnets.json"
# $parameter_path = "azuredeploy.parameters.json"
$resource_group_name = "testrg4"

# prompts login popup; only need to login once per powershell session
# Login-AzureRmAccount

New-AzureRmResourceGroup -Name $resource_group_name -Location "canadacentral"

Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path

New-AzureRmResourceGroupDeployment -Name mainEntryDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path
