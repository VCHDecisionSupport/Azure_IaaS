# configure DNS zone https://azure.microsoft.com/en-us/documentation/articles/dns-getstarted-create-dnszone/
# install Azure PowerShell from https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/

#login
$acct = Login-AzureRmAccount
$acct

# get subscriptions
$SubId = Get-AzureRmSubscription | select-object SubscriptionId
$SubId


#Choose which of your Azure subscriptions to use
Select-AzureRmSubscription -Subscriptionid $SubId.SubscriptionId

# create resource group
$ResGroup = "VCHAzureResourceGroup"
New-AzureRmResourceGroup -Name $ResGroup -location "West US"

# Azure DNS service is managed by the Microsoft.Network resource provider. Your Azure subscription needs to be registered to use this resource provider before you can use Azure DNS. This is a one time operation for each subscription.
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.Network

$dns_zone = "VCH.ca"
New-AzureRmDnsZone -Name $dns_zone -ResourceGroupName $ResGroup


Get-AzureRmDnsRecordSet -ZoneName $dns_zone -ResourceGroupName $ResGroup
