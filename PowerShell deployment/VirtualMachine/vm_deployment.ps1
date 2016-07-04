# http://www.virtualizationadmin.com/articles-tutorials/cloud-computing/microsoft/deploying-virtual-machines-azure-using-azure-resource-manager-powershell-api-part1.html

################################################################################
# AZURE LOGIN AND SUBSCRIPTION INFORMATION
#login
$acct = Login-AzureRmAccount
$acct

# get subscription
$SubId = Get-AzureRmSubscription | Select-Object -Property SubscriptionId
$SubscriptionName = Get-AzureRmSubscription | Select-Object -Property SubscriptionName
$SubId

Select-AzureSubscription -SubscriptionId $SubId.SubscriptionId  -Default $SubscriptionName.SubscriptionName

param (
    [string]$WorkLoad = 100, 
    [string]$OsImageNameName = $env:computername, 
    [string]$Ip = $env:computername, 
    [string]$OsStorageAccountName = $env:computername, 
    [string]$OsStorageSize = $env:computername, 
    [string]$DataStorageAccountName = $env:computername, 
    [string]$DataStorageSize = $env:computername, 
    [string]$Location = $env:computername, 
    [string]$username = $(throw "-username is required."),
    [string]$password = $( Read-Host -asSecureString "Input password" )
)