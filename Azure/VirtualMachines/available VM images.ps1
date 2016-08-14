Clear-Host

$Error.Clear()
Get-AzureRmContext -ErrorAction Continue
$IsSignedIn=$true
foreach ($eacherror in $Error) {
    if ($eacherror.Exception.ToString() -like "*Run Login-AzureRmAccount to login.*") {
        $IsSignedIn=$false
    }
}
$Error.Clear()
If($IsSignedIn -eq $false)
{
    Write-Host "signin to Azure"
    Login-AzureRmAccount
}


$dataCentre = "canadacentral"

# VM Sizes
Get-AzureRmVMSize -Location $dataCentre | Format-Table 

# All Providers
Get-AzureRmResourceProvider -Location $dataCentre -ListAvailable

# Microsoft Publishers
(Get-AzureRmVMImagePublisher -Location $dataCentre| Where-Object {$_.PublisherName -like '*microsoft*' }).PublisherName

# Windows Server + R Server images
$publisherName = "MicrosoftRServer"
$offers = (Get-AzureRmVMImageOffer -Location $dataCentre -PublisherName $publisherName).Offer
$skus = New-Object System.Collections.ArrayList
foreach($offer in $offers)
{
    $offerSkus = Get-AzureRmVMImageSku -Location $dataCentre -PublisherName $PublisherName -Offer $offer
    foreach($sku in $offerSkus)
    {
        $i = $skus.Add($sku)
    }
}
$skus | Format-Table

# Windows Server + SQL Server images
$publisherName = "MicrosoftSQLServer"
$offers = (Get-AzureRmVMImageOffer -Location $dataCentre -PublisherName $publisherName).Offer
$skus = New-Object System.Collections.ArrayList
foreach($offer in $offers)
{
    $offerSkus = Get-AzureRmVMImageSku -Location $dataCentre -PublisherName $PublisherName -Offer $offer
    foreach($sku in $offerSkus)
    {
        $i = $skus.Add($sku)
    }
}
$skus | Format-Table

# Share Point images
$publisherName = "MicrosoftSharePoint"
$offer = (Get-AzureRmVMImageOffer -Location $dataCentre -PublisherName $publisherName).Offer
Get-AzureRmVMImageSku -Location $dataCentre -PublisherName $PublisherName -Offer $offer | Format-Table

# Windows Server images
$publisherName = "MicrosoftWindowsServer"
$offer = (Get-AzureRmVMImageOffer -Location $dataCentre -PublisherName $publisherName).Offer
Get-AzureRmVMImageSku -Location $dataCentre -PublisherName $PublisherName -Offer $offer | Format-Table
