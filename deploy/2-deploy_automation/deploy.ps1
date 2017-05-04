# set current working directory
Set-Location -Path $PSScriptRoot

$resource_group_name = "vchds-sp-test-rg"


# Azure login; only need to login once per powershell session
Login-AzureRmAccount

# create automation account and import resources
Write-Host "Automation Account"
& .\AutomationAccount\deploy.ps1
Set-Location -Path $PSScriptRoot

# import configurations and modules
Write-Host "Automation configurations and modules"
& .\Scripts\deploy.ps1
Set-Location -Path $PSScriptRoot


