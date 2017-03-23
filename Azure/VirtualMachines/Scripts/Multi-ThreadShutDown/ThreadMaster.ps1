# each line of AllServers.txt is a parameter value sent ServerInfo.ps1

Set-Location $PSScriptRoot
# $X = (GC .\AllServers.txt)
# write-host $X
# write-host $X[1]
# write-host $X
$vms = Get-AzureRmVM -ResourceGroupName $env:resourceGroupName

$ObjectList = New-Object System.Collections.ArrayList
foreach($vm in $vms)
{
    Write-Host ("Stopping VM: {0}" -f $vm.Name)
    $ObjectList.Add($vm.Name)
    # Stop-AzureRmVM -Name $vm.Name -ResourceGroupName $env:resourceGroupName -Force
}
Write-Host $ObjectList
.\Run-CommandMultiThreaded.ps1 -Command .\SingleInstruction.ps1 -ObjectList $ObjectList