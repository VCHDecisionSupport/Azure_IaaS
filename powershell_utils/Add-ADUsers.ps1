$pass = ConvertTo-SecureString "Floater1" -AsPlainText -Force
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



Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"