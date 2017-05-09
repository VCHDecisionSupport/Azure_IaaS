# https://www.howtogeek.com/117192/how-to-run-powershell-commands-on-remote-computers/

$pass = ConvertTo-SecureString "Floater1" -AsPlainText -Force
$user = "vch\spVm0"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$target = "spVm0"
Enter-PSSession -ComputerName $target -Credential $cred

