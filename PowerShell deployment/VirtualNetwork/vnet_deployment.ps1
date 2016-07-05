
# https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-overview/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-nsg-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-network-deploy-multinic-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-manage-dns-in-vnet/

################################################################################
# NAMES
# resource group 
$AzureRmResourceGroupName='VCHDSAzureRmResourceGroup'
# data center location
$Location='canadacentral'
# virtual network
$VNetName='VCHDSVNet'
# AddressPrefix for VCHDSVNet
$VNetAddressPrefix='192.168.0.0/16'
# subnet for data warehouse
$SubNetProdDW='VCHDSSubNetProdDW'
# AddressPrefix for VCHDSSubNetProdDW
$SubNetProdDWAddressPrefix='192.168.1.0/24'
# subnet for SharePoint front end
$SubNetProdSP='VCHDSSubNetProdSP'
# AddressPrefix for VCHDSSubNetProdSP
$SubNetProdSPAddressPrefix='192.168.1.1/24'
# Network Security Group Name for VCHDSSubNetProdSP
$NetworkSecurityGroupNameFE="VCHDSNSG-FrontEnd"
# Network Security Group Name for VCHDSSubNetProdDW
$NetworkSecurityGroupNameBE="VCHDSNSG-BackEnd"
# Storage account name
$StorageAccountName="vchstdstorageacct"
$StorageType="Standard_GRS"
# Create the variable to hold the name of the NIC
$NICName="VM1NIC"
$staticIP="192.168.1.101"
$vmName=”VM1”
$vmSize=”Standard_A3”

# Create the variable to hold the publisher name
$pubName = ”MicrosoftWindowsServer”

# Create the variable to hold the offer name
$offerName = ”WindowsServer”


# Create the variable to hold the SKU name
$skuName = ”2012-R2-Datacenter”

# Create the variable to hold the OS disk name
$diskName = ”VM1OSDisk”

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
# new resource group
# New-AzureRmResourceGroup -Name $AzureRmResourceGroup -Location $Location

################################################################################
# CREATE STORAGE ACCOUNTS
$STA = New-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $AzureRmResourceGroupName –Type $StorageType -Location $location


################################################################################
# CREATE VIRTUAL NETWORK AND SUBNETS
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-vnet-arm-ps/


# new virtual network
New-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName -AddressPrefix $VNetAddressPrefix -Location canadacentral   
# get virtual network
$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName


# add subnet inside VCHDSVNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $SubNetProdSP -VirtualNetwork $VNet -AddressPrefix $SubNetProdDWAddressPrefix

# add subnet inside VCHDSVNet
Add-AzureRmVirtualNetworkSubnetConfig -Name $SubNetProdDW -VirtualNetwork $VNet -AddressPrefix $SubNetProdSPAddressPrefix

# save changes to azure
Set-AzureRmVirtualNetwork -VirtualNetwork $VNet 

################################################################################
# CREATE NETWORK SECURITY GROUPS FOR SUBNETS
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-create-nsg-arm-ps/

$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $AzureRmResourceGroupName -Location $Location -Name $NetworkSecurityGroupNameFE -SecurityRules $rule1,$rule2

$VNet = Get-AzureRmVirtualNetwork -ResourceGroupName $AzureRmResourceGroupName -Name $VNetName
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNet -Name $SubNetProdSP -AddressPrefix $SubNetProdSPAddressPrefix -NetworkSecurityGroup $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet


$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Block Internet" -Access Deny -Protocol * -Direction Outbound -Priority 200 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix Internet -DestinationPortRange *

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Block Internet" -Access Deny -Protocol * -Direction Outbound -Priority 200 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix Internet -DestinationPortRange *

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $AzureRmResourceGroupName -Location $Location -Name $NetworkSecurityGroupNameBE -SecurityRules $rule1,$rule2

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $SubNetProdDW -AddressPrefix $SubNetProdDWAddressPrefix -NetworkSecurityGroup $nsg
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet





################################################################################
# CREATE VIRTUAL MACHINE
# Create a public IP address object that can be assigned to the NIC
$pubIP = New-AzureRmPublicIpAddress -Name $NICName -ResourceGroupName $AzureRmResourceGroupName -Location $location -AllocationMethod Dynamic
$subnet=$VNet.Subnets  | Where-Object {$_.Name -eq $SubNetProdSP}

#Create the NIC attached to a subnet, with a public facing IP, and a static private IP
$NIC = New-AzureRmNetworkInterface -Name $NICName -ResourceGroupName $AzureRmResourceGroupName -Location $location -SubnetId $Subnet.Id -PublicIpAddressId $pubIP.Id -PrivateIpAddress $staticIP -NetworkSecurityGroupId $nsg.Id

$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$cred = Get-Credential -Message “Type the name and password of the local administrator account.”

$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate 

# Assign the gallery image to the VM configuration
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName $pubName -Offer $offerName -Skus $skuName -Version "latest"

# Assign the NIC to the VM configuration
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $NIC.Id 

# Create the URI to store the OS disk VHD
$OSDiskUri = $STA.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName  + ".vhd"

# [optional] Assign the OS Disk name and location to the VM configuration
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $OSDiskUri -CreateOption fromImage

# With the virtual machine configuration defined, the actual virtual machine is created using the New-AzureRMVM cmdlet with the configuration information passed as an argument.

New-AzureRmVM -ResourceGroupName $AzureRmResourceGroupName -Location $location -VM $vm



################################################################################
# TODO: 
# https://azure.microsoft.com/en-us/documentation/articles/virtual-network-deploy-multinic-arm-ps/
# https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-manage-dns-in-vnet/
# Assign the operating system to the VM configuration