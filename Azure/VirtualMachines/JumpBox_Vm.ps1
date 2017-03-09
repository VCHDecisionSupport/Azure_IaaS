Clear-Host

$workLoadName = "JumpBox"
$vmSize="Standard_A3"
$skuName = "2012-R2-Datacenter"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "jb-subnet"
#$VmIp = "192.168.0.10"


New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $env:storageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
# 40.85.248.216