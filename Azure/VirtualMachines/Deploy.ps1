Set-ExecutionPolicy Unrestricted

$PSScriptRoot
Set-Location -Path $PSScriptRoot

& '..\ConnectToSubscription.ps1' 

.\New-Vm.ps1

