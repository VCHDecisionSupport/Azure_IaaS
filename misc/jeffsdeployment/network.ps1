
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
$NetworkSecurityGroupNameFE="JeffsNSG"
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
$OSdiskName = "jeffOSDisk"
# get other options:
# Get-AzureRmResourceProvider -Location $Location -ListAvailable
# Get-AzureRmVMImagePublisher -Location $Location | Select-Object {$_.PublisherName}
# Get-AzureRmVMImageOffer -Location $Location -PublisherName $pubName
# Get-AzureRmVMImageSku -Location $Location -PublisherName $pubName -Offer $offerName

# Create the variable to hold the publisher name 
$pubName = "MicrosoftSQLServer"
 # "MicrosoftWindowsServer"

# Create the variable to hold the offer name
$offerName = "SQL2016RC3-WS2012R2"
 #”WindowsServer”

# Create the variable to hold the SKU name
$skuName = "Enterprise"

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
$STA = New-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -Type $StorageType -Location $location


################################################################################
# CREATE VIRTUAL NETWORK AND SUBNETS
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/

# new virtual network
New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName -AddressPrefix $VNetAddressPrefix -Location $Location   
# get virtual network
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName

# add subnet inside VCHDSVNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $SubNetName -VirtualNetwork $VNet -AddressPrefix $SubNetAddressPrefix

# save changes to azure
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet 

###############################################################################
# DEPLOY VIRTUAL MACHINE VIA standard script
# https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-sql-create/
& .\DeployVm.ps1 -WorkLoadName "jeff" -VMSize $vmSize -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName -SubNetName $SubNetName -VNetName $VNetName -StaticIp $StaticIp

