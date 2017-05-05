# set current working directory
Set-Location -Path $PSScriptRoot


$resource_group_name = "vchds-sp-test-rg"


# Azure login; only need to login once per powershell session
Login-AzureRmAccount



Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name 