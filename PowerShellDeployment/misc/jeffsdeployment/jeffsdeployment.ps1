
# https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/
Install-Module AzureRM
Import-Module Azure -ErrorAction SilentlyContinue
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-overview/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-nsg-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-network-deploy-multinic-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-manage-dns-in-vnet/

################################################################################
# deployment parameters
################################################################################
# resource group 
$ResourceGroupName="jeffsRG"
# data center location
$Location="canadacentral"
# virtual network
$VNetName="JeffsVNet"
# AddressPrefix for VNetName
$VNetAddressPrefix="192.168.0.0/16"
# subnet
$SubNetName="JeffsSubNet"
# AddressPrefix for SubNet
$SubNetAddressPrefix="192.168.1.1/24"
# Network Security Group
$NetworkSecurityGroupName="JeffsNSG"
# Storage account name
$StorageAccountName="jeffsstdstorageacct"
$StorageType="Standard_GRS"
# network interface card
$NICName="jeffsNIC"
$staticIP="192.168.1.101"
################################################################################
# VM specs
################################################################################
$vmName="jeffsVM"
$vmSize="Standard_A3"
$OSdiskName = "jeffsOSDisk"
# publisher name 
$publisherName = "MicrosoftSQLServer"
 # "MicrosoftWindowsServer"
# offer name
$offerName = "SQL2016-WS2012R2"
 #WindowsServer
# SKU name
$skuName = "Enterprise"

# get other options:
# Get-AzureRmResourceProvider -Location $Location -ListAvailable
# Get-AzureRmVMImagePublisher -Location $Location | Select-Object {$_.PublisherName}
# Get-AzureRmVMImageOffer -Location $Location -PublisherName $publisherName
# Get-AzureRmVMImageSku -Location $Location -PublisherName $publisherName -Offer $offerName



################################################################################
# AZURE LOGIN AND SUBSCRIPTION INFORMATION
#login
$acct = Login-AzureRmAccount
$acct

# get subscription
$SubId = Get-AzureRmSubscription | Select-Object -Property SubscriptionId
$SubscriptionName = Get-AzureRmSubscription | Select-Object -Property SubscriptionName
$SubId

# CREATE RESOURCE GROUP
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location -Verbose -Force -ErrorAction Stop 

# CREATE STORAGE ACCOUNTS
$sta = New-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -Type $StorageType -Location $location
$sta

################################################################################
# CREATE VIRTUAL NETWORK AND SUBNETS
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/

# new virtual network
New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName -AddressPrefix $VNetAddressPrefix -Location $Location   
# get virtual network
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName
$VNet

# add subnet inside VCHDSVNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $SubNetName -VirtualNetwork $VNet -AddressPrefix $SubNetAddressPrefix

# save changes to azure
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet 

################################################################################
# CREATE NETWORK SECURITY GROUPS FOR SUBNETS
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-nsg-arm-ps/
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
# $rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80
$rule1

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location -Name $NetworkSecurityGroupName -SecurityRules $rule1 #,$rule2
$nsg

$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNet -Name $SubNetProdSP -AddressPrefix $SubNetProdSPAddressPrefix -NetworkSecurityGroup $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet
$VNet

###############################################################################
# DEPLOY VIRTUAL MACHINE VIA standard script
# https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-sql-create/
& .\DeployVm.ps1 -WorkLoadName "jeffs" -PublisherName $publisherName -OfferName $offerName -SkuName $skuName -VMSize $vmSize -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName -SubNetName $SubNetName -VNetName $VNetName -StaticIp $StaticIp

