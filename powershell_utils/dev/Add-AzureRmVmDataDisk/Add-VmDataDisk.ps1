# https://docs.microsoft.com/en-us/powershell/module/azurerm.compute/add-azurermvmdatadisk?view=azurermps-3.8.0

Set-Location -Path $PSScriptRoot
# Login-AzureRmAccount

$resource_group_name = "backup-rg"
$vm_name = "back-from-death"
$uri = "https://vchdsstorageacct.blob.core.windows.net/vhds/testdisk.vhd"
$size_GB = 10
$vm = Get-AzureRmVm -ResourceGroupName $resource_group_name -Name $vm_name

Add-AzureRMVMDataDisk -Name "bob" -VM $vm -VhdUri $uri -Lun 4 -DiskSizeInGB $size_GB -Verbose -CreateOption Empty

Update-AzureRmVM -VM $vm -ResourceGroupName $resource_group_name -Verbose
