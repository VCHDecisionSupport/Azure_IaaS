$vn_name = "jumpboxvm2"



$nics = Get-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName
foreach($nic in $nics)
{
    Write-Host $nic.Name
    Remove-AzureRmNetworkInterface -ResourceGroupName $nic.ResourceGroupName -Name $nic.Name -Force
}

$pips = Get-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName
foreach($pip in $pips)
{
    Write-Host $pip.Name
    Remove-AzureRmPublicIpAddress -ResourceGroupName $pip.ResourceGroupName -Name $pip.Name -Force
}

$vmName = "jumpboxvm2"

$vm = Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName

$nics = Get-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName | Where-Object {$_.VirtualMachine.Id -eq $vm.Id}
$nicName = $nics[0].Name

$pipid = $nics[0].IpConfigurations[0].PublicIpAddress.Id
$pip = Get-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName | Where-Object {$_.Id -eq $pipid }
$pipName = $pip.Name

Remove-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName -Force
Remove-AzureRmNetworkInterface -ResourceGroupName $env:resourceGroupName -Name $nicName -Force
Remove-AzureRmPublicIpAddress -ResourceGroupName $env:resourceGroupName -Name $pipName -Force
