# set current working directory
Set-Location -Path $PSScriptRoot


$resource_group_name = "vchds-sp-test-rg"
$storage_account = "vchdsgeneralstorage"

# Azure login; only need to login once per powershell session
Login-AzureRmAccount

New-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name 
Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name 