param (
    [Parameter(Mandatory=$true)][string]$WorkLoadName,
    [Parameter()][int]$VmId = "1",
    [Parameter(Mandatory=$true)][string]$VMSize,
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$VNetName,
    [Parameter(Mandatory=$true)][string]$SubNetName,
    [Parameter(Mandatory=$true)][string]$StaticIp,
    [Parameter(Mandatory=$true)][string]$StorageAccountName
    [Parameter(Mandatory=$true)][string]$PublisherName="MicrosoftWindowsServer",
    [Parameter(Mandatory=$true)][string]$OfferName="WindowsServer",
    [Parameter(Mandatory=$true)][string]$SkuName="2008-R2-SP1"
)

#############################################################################################################
# browse Virtual Machine availablilty:

# Get-AzureRmResourceProvider -Location $Location -ListAvailable
# Get-AzureRmVMImagePublisher -Location $Location | Select-Object {$_.PublisherName}
# Get-AzureRmVMImageOffer -Location $Location -PublisherName "MicrosoftWindowsServer"
# Get-AzureRmVMImageSku -Location $Location -PublisherName $PublisherName -Offer $offerName
# Get-AzureRmVMSize -Location $Location
#############################################################################################################
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
# # hardcoded Vm settings
# $PublisherName="MicrosoftWindowsServer"
# $OfferName="WindowsServer"
# $SkuName="2008-R2-SP1"

Write-Host "Checking parameter object names"
$rg=Get-AzureRmResourceGroup -Name $ResourceGroupName
$location=$rg.Location
Write-Host $location
$vnet=Get-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName
# $nic=Get-AzureRmNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName
$storage_account=Get-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName
$vm_size = Get-AzureRmVMSize -Location $location | Where-Object {$_.Name -eq $VMSize }

If($null -in @($rg, $location, $vnet, $storage_account, $vm_size))
{
    Write-Host ("invalid parameter(s)")
}

$VMName=$WorkLoadName+"Vm"+$VmId
$NicName=$VMName+"Nic"
$PublicIpName=$VMName+"PIp"
$OsDiskName=$VMName+"OsDisk"

Write-Host ("Configuring Network Interface Card: {0}" -f $NicName)
$subnet=$vnet.Subnets | Where-Object {$_.Name -eq $SubNetName}
$public_ip = New-AzureRmPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName -Location $location -AllocationMethod Dynamic
$nsg=$subnet.NetworkSecurityGroup
$nic=New-AzureRmNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -Location $location -SubnetId $subnet.Id -PublicIpAddressId $public_ip.Id -PrivateIpAddress $StaticIp -NetworkSecurityGroupId $nsg.Id

Write-Host ("Configuring Virtual Machine: {0}" -f $VMName)
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$cred = Get-Credential -UserName "gcrowell_sa" -Message "Type the name and password of the local administrator account."
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate 
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName $PublisherName -Offer $OfferName -Skus $skuName -Version "latest"
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id 
$os_disk_uri = $storage_account.PrimaryEndpoints.Blob.ToString() + "vhds/" + $OsDiskName  + ".vhd"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $OsDiskName -VhdUri $os_disk_uri -CreateOption fromImage

Write-Host ("Deploying Virtual Machine: {0}" -f $VMName)
New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $location -VM $vm -Debug
Write-Host ("Virtual Machine {0} Created." -f $VMName)

# Split-Path "C:\Users\gcrowell\Documents\GITHUB\Azure\PowerShell deployment\VirtualMachine\DeployVm.ps1" | cd
# .\DeployVm.ps1 -WorkLoadName "thisworksgreat" -VMSize "Standard_A3" -ResourceGroupName "VCHDSAzureRmResourceGroup" -StorageAccountName "vchstdstorageacct" -SubNetName "VCHDSSubNetProdSP" -VNetName "VCHDSVNet" -StaticIp "192.168.1.105"

# Get-AzureRmVm -ResourceGroupName "VCHDSAzureRmResourceGroup" | ForEach-Object -Begin {Get-Date} -Process {Remove-AzureRmVM -Name $_.Name -ResourceGroupName $_.ResourceGroupName -Force} -End {Get-Date}