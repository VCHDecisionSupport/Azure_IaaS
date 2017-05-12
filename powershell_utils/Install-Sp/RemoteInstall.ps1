$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "svc_ds_sp_farm"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$target = "spVm1"
Enter-PSSession -ComputerName $target -Credential $cred