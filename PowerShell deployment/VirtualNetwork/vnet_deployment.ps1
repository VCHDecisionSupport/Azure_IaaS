
# https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-overview/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-nsg-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-network-deploy-multinic-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-manage-dns-in-vnet/

################################################################################
# NAMES






################################################################################
# AZURE LOGIN AND SUBSCRIPTION INFORMATION
#login
$acct = Login-AzureRmAccount
$acct

# get subscription
$SubId = Get-AzureRmSubscription | Select-Object -Property SubscriptionId
$SubscriptionName = Get-AzureRmSubscription | Select-Object -Property SubscriptionName
$SubId



################################################################################
# CREATE RESOURCE GROUPS
# resource group 
$AzureRmResourceGroupName='VCHDSAzureRmResourceGroup'
# new resource group
New-AzureRmResourceGroup -Name $AzureRmResourceGroup -Location canadacentral


################################################################################
# CREATE VIRTUAL NETWORK AND SUBNETS
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/

# virtual network
$VNetName='VCHDSVNet'
# new virtual network
New-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName -AddressPrefix 192.168.0.0/16 -Location canadacentral   
# get virtual network
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName

# subnet for data warehouse
$SubNetProdDW='VCHDSSubNetProdDW'
# add subnet inside VCHDSVNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $SubNetProdSP -VirtualNetwork $VNet -AddressPrefix 192.168.1.0/24
# subnet for SharePoint front end
$SubNetProdSP='VCHDSSubNetProdSP'
# add subnet inside VCHDSVNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $SubNetProdDW -VirtualNetwork $VNet -AddressPrefix 192.168.2.0/24

# save changes to azure
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet 

################################################################################
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-nsg-arm-ps/
$NetworkSecurityGroupNameFE="VCHDSNSG-FrontEnd"

$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $AzureRmResourceGroupName -Location canadacentral -Name $NetworkSecurityGroupNameFE -SecurityRules $rule1,$rule2

$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNet -Name $SubNetProdSP -AddressPrefix 192.168.1.0/24 -NetworkSecurityGroup $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet


$NetworkSecurityGroupNameBE="VCHDSNSG-BackEnd"
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Block Internet" -Access Deny -Protocol * -Direction Outbound -Priority 200 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix Internet -DestinationPortRange *

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Block Internet" -Access Deny -Protocol * -Direction Outbound -Priority 200 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix Internet -DestinationPortRange *

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $AzureRmResourceGroupName -Location canadacentral -Name $NetworkSecurityGroupNameBE -SecurityRules $rule1,$rule2

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $SubNetProdDW -AddressPrefix 192.168.2.0/24 -NetworkSecurityGroup $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

################################################################################
# TODO: 
# https://azure.microsoft.com/en-us/documentation/articles/virtual-network-deploy-multinic-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-manage-dns-in-vnet/
