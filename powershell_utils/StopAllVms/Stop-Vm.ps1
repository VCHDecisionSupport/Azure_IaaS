# $Command = $(Read-Host "Enter virtual machine to remove"), 
Param(
    [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$VirtualMachine
)

# Pass comma delimitted because powershell sucks
$Name, $ResourceGroupName = $VirtualMachine -Split ","
Write-Host ("Stopping virtual machine: {0} (ResourceGroup: {1})" -f $Name, $ResourceGroupName)

$Error.Clear()

if (!$Error) {
    Stop-AzureRmVM -Name $Name -ResourceGroupName $ResourceGroupName -Force
}
else {
    Write-Host "ERROR"
    Write-Host $Error
}
