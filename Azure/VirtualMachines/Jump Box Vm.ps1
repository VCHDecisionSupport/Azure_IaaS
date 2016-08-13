Clear-Host

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$storageAccountName = "vchdsstorageacct"

$workLoadName = "JumpBox"
$vmSize="Standard_A3"
$skuName = "2012-R2-Datacenter"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "jb-subnet"
$VmIp = "192.168.0.10"


New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
# 40.85.248.216