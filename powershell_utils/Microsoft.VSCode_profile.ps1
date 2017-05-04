Write-Host "loading profile: $PSCommandPath"
Write-Host "importing modules"
Import-AzureRM
Write-Host "prompting Azure login"
Login-AzureRmAccount

