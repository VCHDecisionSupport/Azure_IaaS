# $Command = $(Read-Host "Enter virtual machine to remove"), 
Param(
    [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$VirtualMachine
)

# Pass comma delimitted because powershell sucks
$vm = Get-AzureRmResource -ResourceId $VirtualMachine
Write-Host ("Restarting virtual machine Id: {0}" -f $VirtualMachine)

$Error.Clear()

if (!$Error) {
    Restart-AzureRmVM -Id $VirtualMachine -Name $vm.Name
}
else {
    Write-Host "ERROR"
    Write-Host $Error
}
