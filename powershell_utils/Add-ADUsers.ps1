$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "vch\dcVm0"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$comp = "dcVm0"

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


$cmd = {
    New-ADUser -Name overlord -AccountExpirationDate $null -ChangePasswordAtLogon $false -SamAccountName overlord -AccountPassword $pass -Enabled $true
}
# Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred



Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


Get-ADUser -Filter "Name -like 'overlord'" -Properties *
