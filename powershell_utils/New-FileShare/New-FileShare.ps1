# set current working directory
Set-Location -Path $PSScriptRoot


# Azure login; only need to login once per powershell session
# Add-AzureRmAccount  



$resource_group_name = "vchds-file-share-rg"
$location = "canadacentral"
$resource_group = Get-AzureRmResourceGroup -Name $resource_group_name
if ($resource_group -eq $null) {
    Write-Host "Creating new resource group: ${resource_group_name}"
    New-AzureRmResourceGroup -Name $resource_group_name -Location $location
}
else {
    Write-Host "resource group already exists: ${resource_group_name}"
}

$storage_account_name = "vchdsgeneralstorage"
$test = Get-AzureRmStorageAccountNameAvailability -Name $storage_account_name
if ($test.NameAvailable) {
    Write-Host "Creating storage account: ${storage_account_name}"
    New-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name -Location $location -SkuName $sku_name
    $storage_account = Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name
}
else {
    Write-Host "storage account: ${storage_account_name} already exists"
    $storage_account = Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name
}
$storage_account

$share_name = "vchdsfileshare"
$storage_share = Get-AzureStorageShare -Name $share_name -Context $storage_account.Context
$storage_share
$storage_account_key = Get-AzureRmStorageAccountKey -StorageAccountName $storage_account.StorageAccountName -ResourceGroupName $resource_group_name



$dst_root_folder = "install_media"
# New-AzureStorageDirectory -ShareName $share_name -Path $dst_root_folder -Context $storage_account.Context

$src_file = "SW_DVD5_SharePoint_Server_2013_64Bit_English_MLF_X18-55474.ISO"
$src_file = "sql2012.zip"
$src_file = "test_file.iso"
$dst_path = Join-Path -Path $dst_root_folder -ChildPath $src_file

# Set-AzureStorageFileContent -ShareName $share_name -Source $src_file -Path $dst_path -Context $storage_account.Context


# See Init-FileShare.ps1