function New-Vm
{
param (
    [Parameter(Mandatory=$true)][string]$PublisherName,
    #[ValidateSet("Low", "Average", "High")]
    [Parameter(Mandatory=$true)][string]$OfferName,
    [Parameter(Mandatory=$true)][string]$SkuName,
    [Parameter()][int]$VmId = "1",
    [Parameter(Mandatory=$true)][string]$WorkLoadName,
    [Parameter(Mandatory=$true)][string]$VMSize,
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$VNetName,
    [Parameter(Mandatory=$true)][string]$SubNetName,
    [Parameter(Mandatory=$true)][string]$PrivateIp,
    [Parameter(Mandatory=$true)][string]$StorageAccountName
)
$elapsed = [System.Diagnostics.Stopwatch]::StartNew()
Write-Host ('-----------------------------------------------')
Write-Host ('input parameters:')
Write-Host ('-----------------------------------------------')
Write-Host ('PublisherName: {0}' -f $PublisherName)
Write-Host ('OfferName: {0}' -f $OfferName)
Write-Host ('SkuName: {0}' -f $SkuName)
Write-Host ('VmId: {0}' -f $VmId)
Write-Host ('WorkLoadName: {0}' -f $WorkLoadName)
Write-Host ('VMSize: {0}' -f $VMSize)
Write-Host ('ResourceGroupName: {0}' -f $ResourceGroupName)
Write-Host ('VNetName: {0}' -f $VNetName)
Write-Host ('SubNetName: {0}' -f $SubNetName)
Write-Host ('PrivateIp: {0}' -f $PrivateIp)
Write-Host ('StorageAccountName: {0}' -f $StorageAccountName)
Write-Host ('-----------------------------------------------')
Write-Host ('component names:')
Write-Host ('-----------------------------------------------')
$VMName=$WorkLoadName+"Vm"+$VmId
$NicName=$VMName+"Nic"
$PublicIpName=$VMName+"Pip"
$OsDiskName=$VMName+"OsDisk"
$dnsName="{0}.canadacentral.cloudapp.azure.com" -f $VMName.ToLower()
Write-Host ('VMName: {0}' -f $VMName)
Write-Host ('NicName: {0}' -f $NicName)
Write-Host ('PublicIpName: {0}' -f $PublicIpName)
Write-Host ('OsDiskName: {0}' -f $OsDiskName)
Write-Host ('DNS Name: {0}' -f $dnsName)
Write-Host ('-----------------------------------------------')
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

Write-Host "Validating parameters"
$rg=Get-AzureRmResourceGroup -Name $ResourceGroupName
$location=$rg.Location
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
$PublicIpName=$VMName+"Pip"
$OsDiskName=$VMName+"OsDisk"
#$BootDiagDiskName=$VMName+"BootDiagDisk"

$os_disk_uri = $storage_account.PrimaryEndpoints.Blob.ToString() + "vhds/" + $OsDiskName  + ".vhd"
#$bootdiag_disk_uri = $storage_account.PrimaryEndpoints.Blob.ToString() + "vhds/" + $BootDiagDiskName  + ".vhd"

Write-Host ("Configuring Public Static IP address")
$public_ip = New-AzureRmPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroupName -Location $location -AllocationMethod Static -DomainNameLabel $vmName.ToLower()

Write-Host ("Configuring Network Interface Card: {0}" -f $NicName)
$subnet=$vnet.Subnets | Where-Object {$_.Name -eq $SubNetName}
$nsg=$subnet.NetworkSecurityGroup
$nic=New-AzureRmNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -Location $location -SubnetId $subnet.Id -PublicIpAddressId $public_ip.Id -PrivateIpAddress $PrivateIp -NetworkSecurityGroupId $nsg.Id

Write-Host ("Configuring Virtual Machine: {0}" -f $VMName)
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

$username = "Floater1"
$securePassword = ConvertTo-SecureString -String $username -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential ($username, $securePassword)
#$cred = Get-Credential -UserName "Floater1" -Message "Type the name and password of the local administrator account."

$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate 
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName $PublisherName -Offer $OfferName -Skus $skuName -Version "latest"
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id 

$vm = Set-AzureRmVMOSDisk -VM $vm -Name $OsDiskName -VhdUri $os_disk_uri -CreateOption fromImage
$vm = Set-AzureRmVMBootDiagnostics -VM $vm -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName -Enable

Write-Host ("Deploying Virtual Machine: {0}" -f $VMName)
New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $location -VM $vm
    
Write-Host ("Virtual Machine {0} Created at {1} with runtime: {2})." -f $VMName, $public_ip.IpAddress, $elapsed.Elapsed.ToString())
Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList "/v:$dnsName.canadacentral.cloudapp.azure.com"
}
# Split-Path "C:\Users\gcrowell\Documents\GITHUB\Azure\PowerShell deployment\VirtualMachine\DeployVm.ps1" | cd
# .\DeployVm.ps1 -WorkLoadName "thisworksgreat" -VMSize "Standard_A3" -ResourceGroupName "VCHDSAzureRmResourceGroup" -StorageAccountName "vchstdstorageacct" -SubNetName "VCHDSSubNetProdSP" -VNetName "VCHDSVNet" -StaticIp "192.168.1.105"

# Get-AzureRmVm -ResourceGroupName "VCHDSAzureRmResourceGroup" | ForEach-Object -Begin {Get-Date} -Process {Remove-AzureRmVM -Name $_.Name -ResourceGroupName $_.ResourceGroupName -Force} -End {Get-Date}