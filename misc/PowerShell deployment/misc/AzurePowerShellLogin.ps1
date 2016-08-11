Write-Host "exeucting AzurePowerShellLogin.ps1"
################################################################################
# AZURE LOGIN AND SUBSCRIPTION INFORMATION
#login
$acct = Login-AzureRmAccount
$acct

# get subscription
$SubId = Get-AzureRmSubscription | Select-Object -Property SubscriptionId
$SubscriptionName = Get-AzureRmSubscription | Select-Object -Property SubscriptionName
$SubId

