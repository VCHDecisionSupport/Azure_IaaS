# https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm

# set current working directory
Set-Location -Path $PSScriptRoot
$resource_group_name = "testrg2"

# prompts login popup; only need to login once per powershell session
Login-AzureRmAccount

New-AzureRmResourceGroup -Name $resource_group_name -Location "canadacentral"


$template_path = "azuredeploy_shared.json"
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path
New-AzureRmResourceGroupDeployment -Name sharedResourcesDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path


# $template_path = "azuredeploy_mainWorkload.json"
# Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path
# New-AzureRmResourceGroupDeployment -Name sharedResourcesDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path

