$subnetName = "jb-subnet"
$addressPrefix = "192.168.0.0/24"
$networkSecurityGroupName = "jb-subnet-nsg"

# get virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName 

# check is subnet exists
If($vnet.SubnetsText.Contains($subnetName))
{
    Write-Host "SubNet already exists"
    $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -OutVariable bob
    Remove-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet
    If($subnet.NetworkSecurityGroupText.Contains($networkSecurityGroupName))
    {
        Write-Host "Remove NSG"
        # (Find-AzureRmResource -ResourceNameContains $networkSecurityGroupName).
        $nsgId = $subnet.NetworkSecurityGroup.Id
        Remove-AzureRmNetworkSecurityGroup -Name $networkSecurityGroupName -ResourceGroupName $env:resourceGroupName -Force 
    }
    Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
}
#$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -OutVariable bob

# add subnet inside vnet
$subnet = Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VNet -AddressPrefix $addressPrefix
# allow remote desktop from internet 
$rdprule = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow www RDP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 3389

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $env:resourceGroupName -Location $env:dataCentre -Name $networkSecurityGroupName -SecurityRules $rdprule

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix $addressPrefix -NetworkSecurityGroup $nsg

# save changes
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
