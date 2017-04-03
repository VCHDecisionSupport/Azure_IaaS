Clear-Host

$env:resourceGroupName = "vchds-root-rg"
$env:dataCentre = "canadacentral"
$env:vnetName = "vchds-vnet"
$env:storageAccountName = "vchdsstorageacct"


$workLoadName = "DW"
$vmSize="Standard_A6"
$skuName = "2012-R2-Datacenter"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "dw-subnet"

New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $env:StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
