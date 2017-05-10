# https://www.howtogeek.com/117192/how-to-run-powershell-commands-on-remote-computers/


$pass = ConvertTo-SecureString "Floater1" -AsPlainText -Force
$user = "spVm3"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$comp = "spVm3"

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


$cmd = {Get-PSDrive -PSProvider "FileSystem" | Format-Table  }
Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred

$cmd = {Get-Disk |Sort-Object Number | Format-Table }
Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"