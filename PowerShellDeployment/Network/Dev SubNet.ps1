# not used

$env:resourceGroupName = "vchds-root-rg"
$env:dataCentre = "canadacentral"
$env:vnetName = "vchds-vnet"
$subnetName = "dev-subnet"
$addressPrefix = "192.168.3.0/24"
$networkSecurityGroupName = "dev-subnet-nsg"

# get virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName

# add subnet inside vnet
$subnet = Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VNet -AddressPrefix $addressPrefix
# allow remote desktop from internet 
$rdprule = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 3389

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $env:resourceGroupName -Location $env:dataCentre -Name $networkSecurityGroupName -SecurityRules $rdprule

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix $addressPrefix -NetworkSecurityGroup $nsg

# save changes
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet