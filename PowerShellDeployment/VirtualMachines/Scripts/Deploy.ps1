Set-ExecutionPolicy Bypass -Scope CurrentUser
Set-ExecutionPolicy Bypass -Scope Process
Set-ExecutionPolicy Bypass -Scope LocalMachine

$PSScriptRoot
Set-Location -Path $PSScriptRoot

& '..\ConnectToSubscription.ps1' 

.\New-Vm.ps1
.\Get-NextIp.ps1
..\Network\Get-IPrange.ps1

& '.\Share Point Vm.ps1'

& '.\Active Directory Domain Controller Vm.ps1'

& '.\Data Warehouse Vm.ps1'

& '.\Jump Box Vm.ps1'
