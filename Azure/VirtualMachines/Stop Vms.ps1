$resourceGroupName = "vchds-root-rg"

$Error.Clear()
Get-AzureRmContext -ErrorAction Ignore
$IsSignedIn=$true
foreach ($eacherror in $Error) {
    if ($eacherror.Exception.ToString() -like "*Run Login-AzureRmAccount to login.*") {
        $IsSignedIn=$false
    }
}
$Error.Clear()
If($IsSignedIn -eq $false)
{
    Write-Host "signin to Azure"
    Login-AzureRmAccount
}

$vms = Get-AzureRmVM -ResourceGroupName $resourceGroupName

foreach($vm in $vms)
{
    Write-Host ("Stopping VM: {0}" -f $vm.Name)
    Stop-AzureRmVM -Name $vm.Name -ResourceGroupName $resourceGroupName -Force
}