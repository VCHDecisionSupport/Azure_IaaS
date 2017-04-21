# $Command = $(Read-Host "Enter virtual machine to remove"), 
Param(
    [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$ResourceGroupName
)

Write-Host ("Removing virtual machine: {0}" -f $ResourceGroupName)

$Error.Clear()
$rg = Get-AzureRmResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue

if (!$Error) {
    Remove-AzureRmResourceGroup -Name $ResourceGroupName -Force
}
else {
    Write-Host "ERROR"
    Write-Host $Error
}

