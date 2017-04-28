$FileUri = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/powershell_utils/RunMeOnVm.ps1"
$Run = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/powershell_utils/RunMeOnVm.ps1"
$vm = Get-AzureRmVM -Name "adVM" -ResourceGroupName "madeisdsrepo"
Set-AzureVMCustomScriptExtension -VM $vm -FileUri $FileUri -Run $Run
$vm | Update-AzureRmVM