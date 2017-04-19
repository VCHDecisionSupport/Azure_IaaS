Param([Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$ObjectList,
    $InputParam = $Null,
    $MaxThreads = 20,
    $SleepTimer = 200,
    $MaxResultTime = 120,
    [HashTable]$AddParam = @{},
    [Array]$AddSwitch = @()
)
# $InputParam | Write-Host
"hello from a thread" | Write-Host
$ObjectList | Write-Host

Stop-AzureRmVM -Name $ObjectList -ResourceGroupName $env:resourceGroupName -Force