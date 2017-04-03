Clear-Host
Set-Location $PSScriptRoot
Z:\GITHUB\SP-on-Azure\Azure\init.ps1

$env:resourceGroupName = "vchds-root-rg"
$env:dataCentre = "canadacentral"
$env:vnetName = "vchds-vnet"
$env:storageAccountName = "vchdsstorageacct"

$workLoadName = "SharePoint"
$vmSize="Standard_A1"
$skuName = "2008-R2-SP1"
$publisherName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$subnetName = "sp-subnet"



New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
#New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
#New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
#New-Vm -WorkLoadName $workLoadName -VMSize $vmSize -ResourceGroupName $env:resourceGroupName -StorageAccountName $StorageAccountName -SubNetName $subnetName -VNetName $env:vnetName -SkuName $skuName -PublisherName $publisherName -OfferName $offerName
