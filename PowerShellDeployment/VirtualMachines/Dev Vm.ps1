# not used, no more cores available in subsription

Clear-Host

$env:resourceGroupName = "vchds-root-rg"
$env:dataCentre = "canadacentral"
$env:vnetName = "vchds-vnet"
$env:storageAccountName = "vchdsstorageacct"
$workLoadName = "Dev"
$subnetName = "dev-subnet"


$vmSize="Standard_A6"
$skuName = "Enterprise"
$publisherName = "MicrosoftRServer"
$offerName = "RServer-WS2012R2"


$VmIp = "192.168.3.10"
$VmId = 1
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -PrivateIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName



$vmSize="Standard_A6"
$skuName = "Enterprise"
$publisherName = "MicrosoftSQLServer"
$offerName = "SQL2016-WS2012R2"

$VmIp = "192.168.3.20"
$VmId = 2
New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -PrivateIp $VmIp -VmId $VmId -SkuName $skuName -PublisherName $publisherName -OfferName $offerName

