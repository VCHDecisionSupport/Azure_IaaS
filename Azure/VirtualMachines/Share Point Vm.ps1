Clear-Host

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$storageAccountName = "vchdsstorageacct"

$subnetName = "sp-subnet"
$workLoadName = "SharePoint"
$vmSize="Standard_A3"


$VmIp = "192.168.1.10"
$VmId = 1
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId $VmId


$VmIp = "192.168.1.20"
$VmId = 2
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId $VmId


$VmIp = "192.168.1.30"
$VmId = 3
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId $VmId
