# https://www.howtogeek.com/117192/how-to-run-powershell-commands-on-remote-computers/

$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "overlord"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$target = "spVm2"
Enter-PSSession -ComputerName $target -Credential $cred

