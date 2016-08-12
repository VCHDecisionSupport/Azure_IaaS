$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$subnetName = "dw-subnet"
$addressPrefix = "192.168.2.0/24"
$networkSecurityGroup = "dw-subnet-nsg"

# get virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName

# add subnet inside vnet
Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VNet -AddressPrefix $addressPrefix

# save changes
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet