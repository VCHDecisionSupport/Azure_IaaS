# set current working directory
Set-Location -Path $PSScriptRoot


$resource_group_name = "vchds-sp-test-rg"
$storage_account_name = "vchdsgeneralstorage"
$file_share_name = "vchdsfileshare"
$location = "canadacentral"
$sku_name = "Standard_LRS"
# Azure login; only need to login once per powershell session

# Login-AzureRmAccount

$test = Get-AzureRmStorageAccountNameAvailability -Name $storage_account_name
$test
if($test.NameAvailable)
{
    New-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name -Location $location -SkuName $sku_name
    $storage_account = Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name
    while($storage_account.ProvisioningState -ne "Succeeded")
    {
        Write-Host "new storage account created: $storage_account_name waiting for azure to get it's act together"
        Start-Sleep -Seconds 10
    }
}
# New-AzureStorageShare -Name $file_share_name -Context $storage_account.Context
$storage_share = Get-AzureStorageShare -Name $file_share_name -Context $storage_account.Context

$storage_account_key = Get-AzureRmStorageAccountKey -StorageAccountName $storage_account.StorageAccountName -ResourceGroupName $resource_group_name
