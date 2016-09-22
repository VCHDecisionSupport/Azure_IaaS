$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$storageAccountName = "vchdsstorageacct"
$storageAccountType = "Standard_LRS"
$storageShareName = "vchdsshare"

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


# check if RG exists
$rg = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    # create root resource group
    Write-Host "create resource group"
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $dataCentre
    # TODO: add tag for automation
}
$Error.Clear()

# check if VNet exists
$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    # new virtual network
    Write-Host "create virtual network"
    New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName -AddressPrefix $addressPrefix -Location $dataCentre   
    # get virtual network
    $vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName
    # save changes
    Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
}
$Error.Clear()

# check if storage account exists
$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    # new storage account
    Write-Host "create storage account"
    New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $dataCentre -Type Standard_GRS 
    $storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
}
$Error.Clear()

$storageAccountKey=(Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value
$storageContext=New-AzureStorageContext $storageAccountName -StorageAccountKey $storageAccountKey
If($err.Count -gt 0)
{
    Write-Host "create storage share"
    New-AzureStorageShare $storageShareName -Context $storageContext
    $storageShare=Get-AzureStorageShare -Name $storageShareName -Context $storageContext
    Write-Host "mount storage share in VMs (https://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-files/#mount-the-file-share)"
}
$Error.Clear()

#$storageAccountKey="adRIYiyg7BzHfUwg7bPhTXUYnU9rHvKhK6B/l+gz6prBZIQl7TotWXys6BslOUTCRA7k1UaSVhsn2HSXA2y5Iw=="
#$storageShareName = "vchdsshare"
#cmdkey /add:$storageShareName.file.core.windows.net /user:$storageAccountName /pass:$storageAccountKey
#$mountCmdArgs=("A: \\{0}.file.core.windows.net\{1}" -f $storageAccountName, $storageShareName)
#net use $mountCmdArgs