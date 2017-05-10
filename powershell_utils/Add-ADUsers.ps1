$pass = ConvertTo-SecureString "#DrainTheSwamp" -AsPlainText -Force
$user = "vch\dcVm0"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass
$comp = "dcVm0"

$users = @("SVC_DS_SP_Farm",
    "SVC_DS_SP_ServiceApp",
    "SVC_DS_SP_WebApp",
    "SVC_DS_SP_WebApp",
    "SVC_DS_SP_ServiceApp"
)

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


$cmd = {
<<<<<<< HEAD
    Get-ADUser -Filter "Name -Like '*SVC_DS_SP_ServiceApp*'" -Properties *
}
# AccountNotDelegated
# AllowReversiblePasswordEncryption
# CannotChangePassword
# CN
# DisplayName
# DoesNotRequirePreAuth
# HomedirRequired


$cmd = {

    Get-ADGroup -Filter "CanonicalName -like '*HealthBC.org/Health/HSSBC/User Accounts/Service*'"

}
Invoke-Command -ScriptBlock $cmd
=======
    New-ADUser -Name overlord -AccountExpirationDate $null -ChangePasswordAtLogon $false -SamAccountName overlord -AccountPassword $pass -Enabled $true
}
# Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred


>>>>>>> c5a6973b48081e560300a57dcd4680f110782c7c

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


Get-ADUser -Filter "Name -like 'overlord'" -Properties *
