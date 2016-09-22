Clear-Host
Set-Location $PSScriptRoot
Z:\GITHUB\SP-on-Azure\Azure\init.ps1

$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$storageAccountName = "vchdsstorageacct"

$workLoadName = "SharePoint"
$vmSize="Standard_A1"
$skuName = "2008-R2-SP1"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "sp-subnet"



New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
#New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
#New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
#New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
