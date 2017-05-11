#####################################################################
### Add user to ADGroup
#####################################################################

Set-Location -Path $PSScriptRoot

$user = "SVC_DS_SP_Farm"
$group_name = "zombie"

$aduser = Get-ADUser -Filter "Name -like '$user'" -Properties *
$adgroup = Get-ADGroup -Filter "Name -like 'zombie'"
if($aduser -eq $null)
{
    Write-Host "`n`nAD User does not exist: $user"
}
if($adgroup -eq $null)
{
    Write-Host "AD Group does not exist: $group_name"
}
else
{
    Write-Host "`n`nadding $user to AD Group $group_name`n`n"
    Get-ADGroupMember -Identity $adgroup
    Add-ADGroupMember -Identity $adgroup -Members $aduser
}

