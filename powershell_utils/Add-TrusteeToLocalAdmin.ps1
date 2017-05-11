# https://www.howtogeek.com/117192/how-to-run-powershell-commands-on-remote-computers/

$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "overlord"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$targets = "spVm0","spVm1","spVm2","spVm3"

Invoke-Command -ComputerName $targets -Credential $cred -ScriptBlock { net localgroup administrators vch\zombie /add }
