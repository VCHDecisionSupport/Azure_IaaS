$resourceGroupName = "vchds-root-rg"
$dataCentre = "canadacentral"
$vnetName = "vchds-vnet"
$addressPrefix = "192.168.0.0/16"
$storageAccountName = "vchdsstorageacct"
$storageAccountType = "Standard_GRS"






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
}

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

# check if storage account exists
$sa = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction SilentlyContinue -ErrorVariable err -OutVariable outvar
If($err.Count -gt 0)
{
    # new storage account
    Write-Host "create storage account"
    New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $dataCentre -Type Standard_GRS 
}
