# based on: https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-3.8.0
Get-Module PowerShellGet -list | Select-Object Name,Version,Path

Install-Module AzureRM

Import-Module AzureRM

Write-Host "`n`n`tLogin using popup! press ALT+TAB`n`n"

Login-AzureRmAccount

New-AzureRmResourceGroup -Name $env:USERNAME -Location $location

$sub_info=Get-AzureSubscription
$sub_info_string=("SubscriptionName: {0}  SubscriptionId: {1}" -f $sub_info.SubscriptionName, $sub_info.SubscriptionId)

Write-Host "`n`n-------------Subscription Info Start---------------"
Write-Host $sub_info_string
Write-Host "-------------Subscription Info End---------------"

Write-Host "`n`nEmail Subscription Info Graham..."

Start-Process "mailto:graham.crowell@vch.ca?Subject=Azure login info for $env:USERNAME&Body=$sub_info_string"