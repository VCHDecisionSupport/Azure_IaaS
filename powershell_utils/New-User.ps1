# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Confirm:$false
# Import-Module ActiveDirectory
Set-Location -Path $PSScriptRoot
$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "SVC_SPDBSSPS008_SQL"

$aduser = Get-ADUser -Filter "Name -like '$user'" -Properties *
if($aduser -eq $null)
{
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
    
    $aduser = Get-ADUser -Filter "Name -like '$user'" -Properties *
    .\Set-ADAccountasLocalAdministrator.ps1 -Computer 'spVm3' -Trustee "vch\$user"
    
}

$aduser
#.\Set-ADAccountasLocalAdministrator.ps1 -Computer 'spVm0,spVm1,spVm2,spVm3,dcVm0,devVm0' -Trustee vch\overlord
# New-ADGroup -Name service -DisplayName service -SamAccountName service
Get-ADGroup -Filter "CanonicalName -like '*HealthBC.org/Health/HSSBC/User Accounts/Service*'"
Get-ADUser -Filter "Name -like 'overlord'" -Properties *