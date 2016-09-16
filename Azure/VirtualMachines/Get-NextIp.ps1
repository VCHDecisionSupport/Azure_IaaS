


function Get-NextIp
{
param (
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$VNetName,
    [Parameter(Mandatory=$true)][string]$SubNetName
)
    $vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName

    $maxIp=(Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet |Where-Object Name -eq $SubNetName | Select-Object AddressPrefix).AddressPrefix.Split("/")[0]
    #$maxIp
    $ips=((Get-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName).IpConfigurations) | Select-Object PrivateIpAddress | Where-Object PrivateIpAddress -Like ($maxIp.SubString(0, $maxIp.LastIndexOf("."))+"*")
    #-Contains $subnetName) #elect-Object PrivateIpAddress # | Where-Object Subnet.Name -eq $subnetName
    #$ips
    foreach($ip in $ips)
    {
        if($ip.PrivateIpAddress -ge $maxIp)# -and $ip.Subnet.Name -eq $subnetName)
        {
            $maxIp=$ip.PrivateIpAddress
        }
    }
    $maxSuffix=[convert]::ToInt32(($maxIp.Split(".")[3] | Select $_))
    $nextSuffix=[convert]::ToString($maxSuffix+10)
    $nextIp=$maxIp.SubString(0, $maxIp.LastIndexOf("."))+"."+$nextSuffix
    return($nextIp) 
}

$resourceGroupName = "vchds-root-rg"
$vnetName = "vchds-vnet"
$subnetName = "sp-subnet"


$x=Get-NextIp -ResourceGroupName $resourceGroupName -VNetName $vnetName -SubNetName $subnetName
$x