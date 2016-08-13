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

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$storageAccountName = "vchdsstorageacct"


$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName

$nicNames = (Get-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName | % {$_.Name})
foreach($nicName in $nicNames)
{
    Write-Host ("Remove network interface card {0}" -f $nicName)
    Remove-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName -Name $nicName -Force
}

$pipNames = (Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName | % {$_.Name})
foreach($pipName in $pipNames)
{
    Write-Host ("Remove public IP {0}" -f $pipName)
    Remove-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Name $pipName -Force
}

$storageContext = (Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName).Context
$vhdss = Get-AzureStorageBlob -Context $storageContext -Container "vhds" | Where-Object{$_.Name -like "*Vm*"} | % {$_.Name}
foreach($vhds in $vhdss)
{
    #Remove-AzureStorageBlob -Blob $diskName -Container "vhds" -Context $storageContext
    Write-Host ("Remove storage disk {0}" -f $vhds)
    Remove-AzureStorageBlob -Blob $vhds -Container "vhds" -Context $storageContext -Force
}

