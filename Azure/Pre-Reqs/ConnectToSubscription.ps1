
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
$env:subscriptionName="Microsoft Azure Sponsorship"
$env:subscription=Get-AzureRmSubscription -SubscriptionName $env:subscriptionName
$env:dataCentre = "canadacentral"

$env:resourceGroupName = "vchds-root-rg"
$env:vnetName = "vchds-vnet"
#$env:vnet=Get-AzureRmVirtualNetwork -ResourceGroupName $env:resourceGroupName -Name $env:vnetName

$env:storageAccountName = "vchdsstorageacct"
#$env:storageAccount=Get-AzureRmStorageAccount -Name $env:storageAccountName -ResourceGroupName $env:resourceGroupName -Verbose

$env:autoAccountName="vchds-auto"



