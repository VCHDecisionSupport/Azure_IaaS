#
#
# Utility Script that removes all the virtual machines asynchronosouly
#
#

Set-Location -Path $PSScriptRoot

$SkipList = $null, $null, "vchds-root-rg"
Write-Host ("Geting list of virtual machines in subscription...`n")

$VirtualMachines = Get-AzureRmVM | Where-Object {$SkipList -notcontains $_.VirtualMachineName}
$VirtualMachineNames = $VirtualMachines.VirtualMachineName

if ($VirtualMachineNames.Count -gt 0) {

  $caption = ("`tRemoving these virtual machines:")

  foreach ($VirtualMachineName in $VirtualMachineNames) {
    $caption += ("`n`t`t$VirtualMachineName")    
  }
  	
  $message = "Are you Sure You Want To Proceed:"
  [int]$defaultChoice = 0
  $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Remove all listed virtual machines."
  $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Cancel."
  $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
  $choiceRTN = $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice)
  if ( $choiceRTN -ne 1 ) {
    .\Run-CommandMultiThreaded.ps1 -Command Remove-VirtualMachine.ps1 -ObjectList $VirtualMachineNames
  }
  else {
    Write-Host ("`nCancelled`n`tNothing removed.")
  }
}
else {
  Write-Host ("`tThere are not virtual machines except those in SkipList:")
  foreach($Skip in $SkipList)
  {
    if($Skip -ne $null)
    {
      Write-Host ("`t`t{0}" -f $Skip)
    }
  }
}
Write-Host ("`nExitting.`n")