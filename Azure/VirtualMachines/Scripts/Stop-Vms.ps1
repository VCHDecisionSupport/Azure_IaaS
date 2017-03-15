$vms = Get-AzureRmVM -ResourceGroupName $env:resourceGroupName

foreach($vm in $vms)
{
    Write-Host ("Stopping VM: {0}" -f $vm.Name)
    Stop-AzureRmVM -Name $vm.Name -ResourceGroupName $env:resourceGroupName -Force
}