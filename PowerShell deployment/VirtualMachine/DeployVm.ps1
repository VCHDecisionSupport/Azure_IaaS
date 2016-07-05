param (
    [Parameter(Mandatory=$true)][string]$VMName,
    [Parameter(Mandatory=$true)][string]$VMSize,
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$NicName,
    [Parameter(Mandatory=$true)][string]$StorageAccountName
)

#############################################################################################################
# browse Virtual Machine availablilty:

# Get-AzureRmResourceProvider -Location $Location -ListAvailable
# Get-AzureRmVMImagePublisher -Location $Location | Select-Object {$_.PublisherName}
# Get-AzureRmVMImageOffer -Location $Location -PublisherName "MicrosoftWindowsServer"
# Get-AzureRmVMImageSku -Location $Location -PublisherName $PublisherName -Offer $offerName
# Get-AzureRmVMSize -Location $Location
#############################################################################################################

# hardcoded Vm settings
$PublisherName="MicrosoftWindowsServer"
$OfferName="WindowsServer"
$SkuName="2008-R2-SP1"

Write-Host "Checking parameter object names"
$rg=Get-AzureRmResourceGroup -Name $ResourceGroupName
$nic=Get-AzureRmNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName
$storage_account=Get-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName
$vm_size = Get-AzureRmVMSize -Location $Location | Where-Object {$_.Name -eq $VMSize }

If($null -in @($rg, $nic, $storage_account, $vm_size))
{
    Write-Host ("invalid parameter(s)")
}

$location=$nic.Location
$OsDiskName=$VMName+"OsDisk"

$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName $PublisherName -Offer $OfferName -Skus $skuName -Version "latest"
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id 
$OSDiskUri = $storage_account.PrimaryEndpoints.Blob.ToString() + "vhds/" + $OsDiskName  + ".vhd"

$vm = Set-AzureRmVMOSDisk -VM $vm -Name $OsDiskName -VhdUri $OSDiskUri -CreateOption fromImage

Write-Host ("Creating Virtual Machine: {0}" -f $VMName)
New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vm
Write-Host ("Virtual Machine {0} Created." -f $VMName)

