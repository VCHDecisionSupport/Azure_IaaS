$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$subnetName = "addc-subnet"
$addressPrefix = "192.168.1.0/24"
$networkSecurityGroupName = "addc-subnet-nsg"

$Error.Clear()
Get-AzureRmContext -ErrorAction Continue
$IsSignedIn=$true
foreach ($eacherror in $Error) 
{
    if ($eacherror.Exception.ToString() -like "*Run Login-AzureRmAccount to login.*") 
    {
        $IsSignedIn=$false
    }
}
$Error.Clear()
If($IsSignedIn -eq $false)
{
    Write-Host "signin to Azure"
    Login-AzureRmAccount
}

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
        # (Find-AzureRmResource -ResourceNameContains $networkSecurityGroupName).
        $nsgId = $subnet.NetworkSecurityGroup.Id
        Remove-AzureRmNetworkSecurityGroup -Name $networkSecurityGroupName -ResourceGroupName $resourceGroupName -Force 
    }
    Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
}
#$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet -OutVariable bob

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

