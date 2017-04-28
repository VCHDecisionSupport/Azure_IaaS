Clear-Host

Write-Host $PSCommandPath

..\Azure\ConnectToSubscription.ps1

$env:resourceGroupName = "vchds-root-rg"
$env:dataCentre = "canadacentral"
$env:vnetName = "vchds-vnet"
$env:storageAccountName = "vchdsstorageacct"

$env:vnetName = "vchds-vnet"
$subnetName = "jb-subnet"
$addressPrefix = "192.168.0.0/24"
$networkSecurityGroupName = "jb-subnet-nsg"

$vmName = 'jumpboxvm1'

$vnet = Get-AzureRmVirtualNetwork -Name $env:vnetName -ResourceGroupName $env:resourceGroupName

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName

$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName

Get-AzureRmNetworkSecurityGroup -ResourceGroupName $env:resourceGroupName | Select Name

$nsg = Get-AzureRmNetworkSecurityGroup -Name 'jb-subnet-nsg' -ResourceGroupName $env:resourceGroupName

$rule = Get-AzureRmNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg

$rule 

$httprule = New-AzureRmNetworkSecurityRuleConfig -Name http-rule -Description "Allow HTTP" `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 80

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -NetworkSecurityGroup $nsg -AddressPrefix $addressPrefix

Set-AzureRmVirtualNetwork -VirtualNetwork $vnet