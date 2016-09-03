$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$subnetName = "dw-subnet"
$addressPrefix = "192.168.3.0/24"
$networkSecurityGroupName = "dw-subnet-nsg"

# get virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName

# add subnet inside vnet
$subnet = Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VNet -AddressPrefix $addressPrefix
# block from internet to subnet
$wwwrule = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Deny All Inbound Internet" `
    -Access Deny -Protocol Tcp -Direction Inbound -Priority 100 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange *

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $dataCentre -Name $networkSecurityGroupName -SecurityRules $wwwrule

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix $addressPrefix -NetworkSecurityGroup $nsg

# save changes
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet