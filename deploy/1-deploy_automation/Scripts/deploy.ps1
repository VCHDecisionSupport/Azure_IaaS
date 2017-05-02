Set-Location -Path $PSScriptRoot

# Login-AzureRmAccount

$resource_group_name = "vchds-auto-rg"
$auto_account = "vchds-auto"

Write-Host "importAllModules..."
.\importAllModules.ps1 -moduleAutomationAccount $auto_account -moduleResourceGroup $resource_group_name

Write-Host "importAllConfigurations..."
.\importAllConfigurations.ps1 -dscAutomationAccount $auto_account -dscResourceGroup $resource_group_name