Set-Location -Path $PSScriptRoot

########################################################
# 
# initializes enviroment variables and other pre-requistes
# 
# signin, select subscription, create ifne: resourc egroup, vnet, storage account, storage share
# 
########################################################

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


Write-Host "Setting env variables to deployment values"
$env:subscriptionName="Microsoft Azure Enterprise"
Select-AzureRmSubscription -SubscriptionName $env:subscriptionName
Set-AzureRmContext -SubscriptionName $env:subscriptionName
# $env:subscription=Get-AzureRmSubscription -SubscriptionName $env:subscriptionName

#"Canada Central"
$env:dataCentre = "canadacentral"
$env:resourceGroupName = "vchds-root-rg"
# Get-AzureRmResourceGroup

$env:vnetName = "vchds-vnet"
# $env:vnet=Get-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName

$env:storageAccountName = "vchdsstorageacct"
#$env:storageAccount=Get-AzureRmStorageAccount -Name $env:storageAccountName -ResourceGroupName $env:resourceGroupName -Verbose

$env:autoAccountName="vchds-auto"


$addressPrefix = "192.168.0.0/16"
$env:storageAccountType = "Standard_LRS"
$env:storageShareName = "vchdsshare"
$env:keyVaultName = "vchDsKeyVault"

# check if RG exists
$rg = Get-AzureRmResourceGroup -Name $env:resourceGroupName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    Write-Host "create resource group"
    New-AzureRmResourceGroup -Name $env:resourceGroupName -Location $env:dataCentre
    # TODO: add tag for automation
}
$Error.Clear()

# check if key vault exists
$rg = Get-AzureRmKeyVault -ResourceGroupName $env:resourceGroupName -VaultName $env:keyVaultName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    Write-Host "create key vault"
    New-AzureRmKeyVault -VaultName $env:keyVaultName -ResourceGroupName $env:resourceGroupName -Location $env:dataCentre -EnabledForDeployment -EnabledForTemplateDeployment
    # TODO: add tag for automation
}
$Error.Clear()


# check if VNet exists
$vnet = Get-AzureRmVirtualNetwork -Name $env:vnetName -ResourceGroupName $env:resourceGroupName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    # new virtual network
    Write-Host "create virtual network"
    New-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName -AddressPrefix $addressPrefix -Location $env:dataCentre   
    # get virtual network
    $vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName
    # save changes
    Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
}
$Error.Clear()

# check if storage account exists
$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName -Name $env:storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    # new storage account
    Write-Host "create storage account"
    New-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName -Name $env:storageAccountName -Location $env:dataCentre -Type Standard_GRS 
    $storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $env:resourceGroupName -Name $env:storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
}
$Error.Clear()

$storageAccountKey=(Get-AzureRmStorageAccountKey -ResourceGroupName $env:resourceGroupName -Name $env:storageAccountName)[0].Value
$storageContext=New-AzureStorageContext $env:storageAccountName -StorageAccountKey $storageAccountKey
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
#cmdkey /add:$storageShareName.file.core.windows.net /user:$env:storageAccountName /pass:$storageAccountKey
#$mountCmdArgs=("A: \\{0}.file.core.windows.net\{1}" -f $env:storageAccountName, $storageShareName)
#net use $mountCmdArgs