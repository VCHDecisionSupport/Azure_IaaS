
# https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-3.8.0
Get-Module PowerShellGet -list | Select-Object Name,Version,Path

Install-Module AzureRM

Import-Module AzureRM

Write-Host "`n`n`tLogin using popup! press ALT+TAB`n`n"

Login-AzureRmAccount

New-AzureRmResourceGroup -Name $env:USERNAME -Location $location