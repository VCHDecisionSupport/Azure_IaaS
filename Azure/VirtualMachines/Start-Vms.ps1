$vms = Get-AzureRmVM -ResourceGroupName $env:resourceGroupName

foreach($vm in $vms)
{
    Write-Host ("Stopping VM: {0}" -f $vm.Name)
    Start-AzureRmVM -Name $vm.Name -ResourceGroupName $env:resourceGroupName -Force
}