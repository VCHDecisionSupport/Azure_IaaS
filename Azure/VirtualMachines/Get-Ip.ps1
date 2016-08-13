


function Get-NextIp
{
param (
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$VNetName,
    [Parameter(Mandatory=$true)][string]$SubNetName
)
$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName

$ips = New-Object System.Collections.ArrayList
foreach($subnet in $vnet.Subnets)
{
    # $subnet.Name
    $subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnet.Name -VirtualNetwork $vnet
    # $subnet.AddressPrefix
    $ip, $cidr = $subnet.AddressPrefix.Split("/")
    # $ip, $cidr
    $iprange = Get-IPrange -ip $ip -cidr $cidr | % {$_.split(".")[3]}
    $iprange = Get-IPrange -ip $ip -cidr $cidr | Where-Object {[convert]::ToInt32($_.split(".")[3], 10) % 10 -eq 0 -and [convert]::ToInt32($_.split(".")[3], 10) -gt 0}
    $ips.AddRange($iprange)
}
$nics = Get-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName
    foreach($nic in $nics)
    {
        foreach($ipconfig in $nic.IpConfigurations)
        {
            # $ipconfig.PrivateIpAddress
            $ips.Remove($ipconfig.PrivateIpAddress)
        }

    }
$ips[0]
return 
}

$resourceGroupName = "vchds-root-rg"
$vnetName = "vchds-vnet"
$subnetName = "sp-subnet"

Get-NextIp -ResourceGroupName $resourceGroupName -VNetName $vnetName -SubNetName $subnetName