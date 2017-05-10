$FileUri = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/powershell_utils/RunMeOnVm.ps1"
$Run = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/powershell_utils/RunMeOnVm.ps1"
$vm = Get-AzureRmVM -Name "adVM" -ResourceGroupName "madeisdsrepo"
$location = "canadacentral"
# Set-AzureRmVMCustomScriptExtension -VM $vm -FileUri $FileUri -Run $Run
# Set-AzureRmVMCustomScriptExtension -ResourceGroupName "madeisdsrepo" -Location $location -VMName "adVM" -Name "RunMeOnVm.ps1" -TypeHandlerVersion "1.1" -StorageAccountName "thisisdefuniquwe" -StorageAccountKey "Zr0vf2rSdxMjrKG1zLdXEEJEshzUNBdoTfxW3RY4qL+1AZwpAp8ao4/W79saxoyMVO8U6afEYQiLQ8Sr9wm8vA==" -FileName "RunMeOnVm.ps1" -ContainerName "Scripts" -FileUri $FileUri


$StorageAccountName = "thisisdefuniquwe"
$StorageKey = "Zr0vf2rSdxMjrKG1zLdXEEJEshzUNBdoTfxW3RY4qL+1AZwpAp8ao4/W79saxoyMVO8U6afEYQiLQ8Sr9wm8vA=="
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$containername = "scripts"
$localfiledirectory = ""
$blobname = "RunMeOnVm.ps1"
$localfile = $localfiledirectory + $blobname
Set-AzureStorageBlobContent -File $localfile -Container $containername -Blob $blobname -Context $ctx


$ResourceGroup = "madeisdsrepo"
$VMName = "adVM"

Set-AzureRmVMCustomScriptExtension -ResourceGroupName $ResourceGroup -VMName $VMName -Name "CustomScriptExtension" -TypeHandlerVersion "1.4" -StorageAccountName $StorageAccountName -ContainerName $ContainerName -StorageAccountKey $StorageKey -Location $location -FileName "RunMeOnVm.ps1" -Run "RunMeOnVm.ps1"

