Clear-Host

$workLoadName = "ADDC"
$vmSize="Standard_A3"
$skuName = "2012-R2-Datacenter"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "addc-subnet"

New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $env:storageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
