# Trigger
$Trigger = New-JobTrigger -Daily -At "9:12 PM"

# Options
$option1 = New-ScheduledJobOption

$Script="C:\Users\user\Source\Repos\Azure_IaaS\Azure\VirtualMachines\Scripts\AutoOffJob.ps1"

Register-ScheduledJob -Name LogStuff -FilePath $Script -Trigger  $Trigger -ScheduledJobOption $option1
# Unregister-ScheduledJob -Name LogStuff
Get-ScheduledJob