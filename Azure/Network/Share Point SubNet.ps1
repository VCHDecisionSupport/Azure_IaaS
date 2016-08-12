$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$subnetName = "sp-subnet"
$addressPrefix = "192.168.1.0/24"
$networkSecurityGroupName = "sp-subnet-nsg"


# get virtual network
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName 

# check is subnet exists
If($vnet.SubnetsText.Contains($subnetName))
{
    Write-Host "SubNet already exists"
    $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -OutVariable bob
    Remove-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet
    If($subnet.NetworkSecurityGroupText.Contains($networkSecurityGroupName))
    {
        Write-Host "Remove NSG"
        (Find-AzureRmResource -ResourceNameContains $networkSecurityGroupName).
        $nsgId = $subnet.NetworkSecurityGroup.Id
        Remove-AzureRmNetworkSecurityGroup -Name $networkSecurityGroupName -ResourceGroupName $resourceGroupName -Force
    }
    
    
    

}
#$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -OutVariable bob

# add subnet inside vnet
$subnet = Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VNet -AddressPrefix $addressPrefix
# block from internet to subnet

$noAccessRule = New-AzureRmNetworkSecurityRuleConfig -Name nowebrule -Description "Block Access" -Access Deny -Protocol * -Direction Outbound -Priority 200 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix Internet -DestinationPortRange *

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $dataCentre -Name $networkSecurityGroupName -SecurityRules $noAccessRule

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix $addressPrefix -NetworkSecurityGroup $nsg

# save changes
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet