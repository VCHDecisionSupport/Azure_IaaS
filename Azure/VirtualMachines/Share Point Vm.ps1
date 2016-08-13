Clear-Host

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$storageAccountName = "vchdsstorageacct"

$workLoadName = "SharePoint"
$vmSize="Standard_A6"
$skuName = "2008-R2-SP1"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "sp-subnet"


$VmIp = "192.168.1.10"
$VmId = 1
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName


$VmIp = "192.168.1.20"
$VmId = 2
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName


$VmIp = "192.168.1.30"
$VmId = 3
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -StaticIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
