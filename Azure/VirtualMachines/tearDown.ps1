#todo: function to drop all child resources attached to a VM so it can be redeployed later
#todo: extend to drop subnets


$Error.Clear()
Get-AzureRmContext -ErrorAction Continue
$IsSignedIn=$true
foreach ($eacherror in $Error) {
    if ($eacherror.Exception.ToString() -like "*Run Login-AzureRmAccount to login.*") {
        $IsSignedIn=$false
    }
}
$Error.Clear()
If($IsSignedIn -eq $false)
{
    Write-Host "signin to Azure"
    Login-AzureRmAccount
}

$env:resourceGroupName = "vchds-root-rg"
$env:dataCentre = "canadacentral"
$env:vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$env:storageAccountName = "vchdsstorageacct"


$vnet = Get-AzureRmVirtualNetwork -Name $env:vnetName -ResourceGroupName $env:resourceGroupName

$nicNames = (Get-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName | % {$_.Name})
foreach($nicName in $nicNames)
{
    Write-Host ("Remove network interface card {0}" -f $nicName)
    Remove-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName -Name $nicName -Force
}

$pipNames = (Get-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName | % {$_.Name})
foreach($pipName in $pipNames)
{
    Write-Host ("Remove public IP {0}" -f $pipName)
    Remove-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName -Name $pipName -Force
}

$storageContext = (Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName).Context
$vhdss = Get-AzureStorageBlob -Context $storageContext -Container "vhds" | Where-Object{$_.Name -like "*Vm*"} | % {$_.Name}
foreach($vhds in $vhdss)
{
    #Remove-AzureStorageBlob -Blob $diskName -Container "vhds" -Context $storageContext
    Write-Host ("Remove storage disk {0}" -f $vhds)
    Remove-AzureStorageBlob -Blob $vhds -Container "vhds" -Context $storageContext -Force
}


# try again
$vnet=Get-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName
$storageContext = (Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName).Context


$vmName='JumpBoxvm1'
$vm=Get-AzureRmVm -ResourceGroupName $env:resourceGroupName -Name $vmName

$nicName=$vm.NetworkInterfaceIDs[0].Split('/')[-1]
$nic=Get-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName -Name $nicName
$pip=Get-AzureRmNetworkInterfaceIpConfig -NetworkInterface $nic
$subnetName=$nic.IpConfigurations.Subnet.Id.Split('/')[-1]
$subnet=$pip.Subnet
($subnet.NetworkSecurityGroup).Subnets

$vm.StorageProfile.OsDisk.Vhd

Remove-AzureRmNetworkInterfaceIpConfig -Name $nicName -NetworkInterface $nic
Remove-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName -Name $nicName -Force






$storageAccount=Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName


$nicName

Remove-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName -Name 'SharePointVm1Pip'


$pipName='JumpBoxVm1Pip'
$nsgName='jb-subnet-nsg'
$subnetName='jb-subnet'
Remove-AzureRmVM -Name $vmName -ResourceGroupName $env:resourceGroupName -Force
Remove-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName -Name $nicName -Force
Remove-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName -Name $pipName -Force
Remove-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName
Remove-AzureRmNetworkSecurityGroup -ResourceGroupName $env:resourceGroupName -Name $nsgName -Force
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName
