Set-Location -Path $PSScriptRoot
$resource_group_name = "vch-ds-rg"
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$location = "canadacentral"
$deployment_name = "addcDeployment"


# Login-AzureRmAccount

New-AzureRmResourceGroup -Name $resource_group_name -Location $location

New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path

# https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-3.8.0
Get-Module PowerShellGet -list | Select-Object Name,Version,PathInstall Azure PowerShell

Install-Module AzureRM

Import-Module AzureRM

Write-Host "`n`n`tLogin using popup! press ALT+TAB`n`n"
Login-AzureRmAccount

New-AzureRmResourceGroup -Name $env:USERNAME -Location $location