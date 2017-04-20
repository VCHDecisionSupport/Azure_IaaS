#
#
# Utility Script that removes all the resource groups asynchronosouly
#
#

Set-Location -Path $PSScriptRoot

Write-Host ("Removing all Azure Resource Groups in active Azure Subscription`n")

$SkipList = $null, $null, "vchds-root-rg"
$ResourceGroups = Get-AzureRmResourceGroup | Where-Object {$SkipList -notcontains $_.ResourceGroupName}
$ResourceGroupNames = $ResourceGroups.ResourceGroupName

if ($ResourceGroupNames.Count -gt 0) {
    Write-Host ("`tRemoving these Resource Groups:")
    Write-Host ("`t$ResourceGroupNames")
    Read-Host -Prompt "`tEnter Anything to Confirm"

    .\Run-CommandMultiThreaded.ps1 -Command Remove-ResourceGroup.ps1 -ObjectList $ResourceGroupNames
}
else {
    Write-Host ("`tThere are not resource groups to delete.`n")
}
