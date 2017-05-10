$pass = ConvertTo-SecureString "Floater1" -AsPlainText -Force
$user = "vch\dcVm0"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass


# Connect-PSSession -ComputerName "dcvm0" -Credential $cred -Name "helo"
# Import-Module ServerManager
# Add-WindowsFeature RSAT-AD-PowerShell
# Import-Module ActiveDirectory

# Get-ADUser -Filter "name -eq '*SVC_DS_SP_ServiceApp*'"
# $user = "testADservice"
# $dns = "dcvm0.vch.ca"
# $DNSHostName = $user+".vch.ca"

# $adAdminUser = "adFloater1"

# #New-ADServiceAccount -Name $user -AccountPassword $pass -Credential $cred -Description "just a test" -Server "spVm3" -ServicePrincipalNames $user -RestrictToSingleComputer 
# New-ADServiceAccount $user -DNSHostName $dns -Enabled $true -Verbose -Debug
# # -Credential $cred
$share_display_root = "\\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare"
Get-PSDrive -PSProvider 'FileSystem' | Where-Object {$_.DisplayRoot -like "*$share_display_root*"}
Get-PSDrive -PSProvider 'FileSystem' | Where-Object {$_.DisplayRoot -like "*$share_display_root*"} | Select-Object {$_.CurrentLocation}
(Get-PSDrive -PSProvider 'FileSystem').Description
Get-Volume
# Set-Volume -