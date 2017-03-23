Set-Location -Path $PSScriptRoot
Get-ChildItem

& .\Azure\init.ps1
& .\Azure\Pre-Reqs\ConnectToSubscription.ps1
& .\Azure\Pre-Reqs\Get-NextIp.ps1
& .\Azure\Pre-Reqs\New-Vm.ps1

#
# & .\Azure\init.ps1
# Import-Module -Name .\Azure\Network\addc-subnet.ps1
# Import-Module -Name .\Azure\VirtualMachines\ADDC\ADDC_Vm.ps1



