# set current working directory
Set-Location -Path $PSScriptRoot

$resource_group_name = "vchds-sp-test-rg"
$auto_account = "vchds-auto"


# Azure login; only need to login once per powershell session
# Add-AzureRmAccount



# create automation account and import resources
Write-Host "Automation Account"
# deploy resources declared in $template_path
$template_path = "AutomationAccount/azuredeploy.json"
$parameter_path = "AutomationAccount/azuredeploy.parameters.json"
$deployment_name = "autoAccountDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path



# import configurations and modules
Set-Location -Path $PSScriptRoot\Scripts
Write-Host "Automation configurations and modules: "
Get-Location
Write-Host "importAllModules into $auto_account..."
.\importAllModules.ps1 -moduleAutomationAccount $auto_account -moduleResourceGroup $resource_group_name

Write-Host "importAllConfigurations into $auto_account..."
.\importAllConfigurations.ps1 -dscAutomationAccount $auto_account -dscResourceGroup $resource_group_name

