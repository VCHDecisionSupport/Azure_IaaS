# set current working directory
Set-Location -Path $PSScriptRoot


# Azure login; only need to login once per powershell session
# Login-AzureRmAccount  


$resource_group_name = "vchds-file-share-rg"
$location = "canadacentral"
New-AzureRmResourceGroup -Name $resource_group_name -Location $location

$share_name = "vchdsfileshare"

$test = Get-AzureRmStorageAccountNameAvailability -Name $storage_account_name
$test
if ($test.NameAvailable) {
    New-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name -Location $location -SkuName $sku_name
    $storage_account = Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name
    while ($storage_account.ProvisioningState -ne "Succeeded") {
        Write-Host "new storage account created: $storage_account_name waiting for azure to get it's act together"
        Start-Sleep -Seconds 10
    }
}
else {
    $storage_account = Get-AzureRmStorageAccount -ResourceGroupName $resource_group_name -Name $storage_account_name
}
Set-AzureRmStorageAccount -ResourceGroupName $resource_group_name -AccountName $storage_account_name -Type $sku_name

New-AzureStorageShare -Name $share_name -Context $storage_account.Context
$storage_share = Get-AzureStorageShare -Name $share_name -Context $storage_account.Context
$storage_account_key = Get-AzureRmStorageAccountKey -StorageAccountName $storage_account.StorageAccountName -ResourceGroupName $resource_group_name




# "SW_DVD5_SharePoint_Server_2013_64Bit_English_MLF_X18-55474.ISO"
$src_file = "test_file.iso"
$dst_root_folder = "install_media"
$dst_path = Join-Path -Path $dst_root_folder -ChildPath $src_file

New-AzureStorageDirectory -ShareName $share_name -Path $dst_root_folder -Context $storage_account.Context
Set-AzureStorageFileContent -ShareName $share_name -Source $src_file -Path $dst_path -Context $storage_account.Context
