Clear-Host

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$storageAccountName = "vchdsstorageacct"
$storageAccountType = "Standard_GRS"

$subnetName = "sp-subnet"
$workLoadName = "SharePoint"
$vmSize="Standard_A3"


$VmIp = "192.168.1.10"
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId 1


$VmIp = "192.168.1.20"
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId 1


$VmIp = "192.168.1.30"
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId 1
