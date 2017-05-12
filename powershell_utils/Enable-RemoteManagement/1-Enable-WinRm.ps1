# https://www.howtogeek.com/117192/how-to-run-powershell-commands-on-remote-computers/

# run on target VM that you want to remotley run powershell

Set-Location -Path $PSScriptRoot

Enable-PSRemoting -Force
Get-Item wsman:\localhost\client\trustedhosts
Set-Item wsman:\localhost\client\trustedhosts * -Force
Restart-Service WinRM -Force

Test-WsMan dcVm0
Test-WsMan spVm0
Test-WsMan spVm1
Test-WsMan spVm2
Test-WsMan spVm3


