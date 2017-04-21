#
#
# Utility Script that removes all the resource groups asynchronosouly
#
#

Set-Location -Path $PSScriptRoot

$SkipList = $null, $null, "vchds-root-rg"
Write-Host ("Geting list of Resource Groups in subscription...`n")

$ResourceGroups = Get-AzureRmResourceGroup | Where-Object {$SkipList -notcontains $_.ResourceGroupName}
$ResourceGroupNames = $ResourceGroups.ResourceGroupName

if ($ResourceGroupNames.Count -gt 0) {

  $caption = ("`tRemoving these Resource Groups:")

  foreach ($ResourceGroupName in $ResourceGroupNames) {
    $caption += ("`n`t$ResourceGroupName")    
  }
  	
  $message = "Are you Sure You Want To Proceed:"
  [int]$defaultChoice = 0
  $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Remove all listed Resource Groups."
  $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Cancel."
  $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
  $choiceRTN = $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice)
  if ( $choiceRTN -ne 1 ) {
    .\Run-CommandMultiThreaded.ps1 -Command Remove-ResourceGroup.ps1 -ObjectList $ResourceGroupNames
  }
  else {
    Write-Host ("`nCancelled`n`tNothing removed.")
  }
}
else {
  Write-Host ("`tThere are not resource groups except those in SkipList:")
  foreach($Skip in $SkipList)
  {
    if($Skip -ne $null)
    {
      Write-Host ("`t`t{0}" -f $Skip)
    }
  }
}
Write-Host ("`nExitting.`n")