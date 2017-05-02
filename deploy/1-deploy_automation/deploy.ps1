# set current working directory
Set-Location -Path $PSScriptRoot

$resource_group_name = "vchds-sp-test2-rg"


# Azure login; only need to login once per powershell session
Login-AzureRmAccount

# create new resource group
$location = "canadacentral"
New-AzureRmResourceGroup -Name $resource_group_name -Location $location

# create automation account and import resources
Write-Host "Automation Account"
& .\AutomationAccount\deploy.ps1

Write-Host "Automation configurations and modules"
# import configurations and modules
& .\Scripts\deploy.ps1


