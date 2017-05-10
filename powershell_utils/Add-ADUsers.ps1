$pass = ConvertTo-SecureString "Floater1" -AsPlainText -Force
$user = "vch\dcVm0"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$comp = "dcVm0"

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


$cmd = {

    New-ADUser -

}
Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred



Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"