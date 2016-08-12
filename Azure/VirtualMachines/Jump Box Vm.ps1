Clear-Host

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$storageAccountName = "vchdsstorageacct"
$storageAccountType = "Standard_GRS"

$subnetName = "jb-subnet"
$VmIp = "192.168.0.10"
$vmSize="Standard_A3"
$workLoadName = "JumpBox"

New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp
