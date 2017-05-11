# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Confirm:$false -Scope LocalMachine
Import-Module ActiveDirectory
Set-Location -Path $PSScriptRoot
$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "SVC_DS_SP_Farm"

$aduser = Get-ADUser -Filter "Name -like '$user'" -Properties *
if($aduser -eq $null)
{
    Write-Host "`n`nCreating new AD User: $user"
    New-ADUser -Name $user `
        -AccountExpirationDate $null `
        -AccountNotDelegated $false `
        -AccountPassword $pass `
        -CannotChangePassword $true `
        -ChangePasswordAtLogon $false `
        -DisplayName $user `
        -Enabled $true `
        -SamAccountName $user `
        -TrustedForDelegation $false # if kyperors then this is true on webapp account
}
else 
{
    Write-Host "`n`nAD User: $user already exists"
}
Get-ADUser -Filter "Name -like '$user'"

