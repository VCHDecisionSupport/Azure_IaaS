Set-Location $PSScriptRoot

$storageAccount=Get-AzureRmStorageAccount -Name $env:storageAccountName -ResourceGroupName $env:resourceGroupName -Verbose

# provision data disks for vm drives: H,I,J,K

$dataDiskName="sqldata"
$dataDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $dataDiskName  + ".vhd"
$vmName="SharePointVm1"
$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName
$vm=Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -VhdUri $dataDiskUri -Caching ReadWrite -DiskSizeInGB 500 -Lun 2 -CreateOption Empty
Update-AzureRmVM -VM $vm -ResourceGroupName $env:resourceGroupName

$dataDiskName="sqllog"
$dataDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $dataDiskName  + ".vhd"
$vmName="SharePointVm1"
$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName
$vm=Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -VhdUri $dataDiskUri -Caching ReadWrite -DiskSizeInGB 500 -Lun 3 -CreateOption Empty
Update-AzureRmVM -VM $vm -ResourceGroupName $env:resourceGroupName

$dataDiskName="sqlbackup"
$dataDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $dataDiskName  + ".vhd"
$vmName="SharePointVm1"
$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName
$vm=Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -VhdUri $dataDiskUri -Caching ReadWrite -DiskSizeInGB 500 -Lun 4 -CreateOption Empty
Update-AzureRmVM -VM $vm -ResourceGroupName $env:resourceGroupName


$dataDiskName="sqlwaldo"
$dataDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $dataDiskName  + ".vhd"
$vmName="SharePointVm1"
$vm=Get-AzureRmVM -ResourceGroupName $env:resourceGroupName -Name $vmName
$vm=Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -VhdUri $dataDiskUri -Caching ReadWrite -DiskSizeInGB 500 -Lun 5 -CreateOption Empty
Update-AzureRmVM -VM $vm -ResourceGroupName $env:resourceGroupName
