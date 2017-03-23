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
# $ObjectList[0] | Write-Host
# $ObjectList[1] | Write-Host
# $ParameterName
# Get-Date | Write-Host 
# $ObjectList.ToString()| write-host 
# (Get-Date -Format"yyyy-MM-ddThh:mm:ss").ToString() | Out-File -FilePath "C:\Users\user\Source\Repos\Azure_IaaS\Azure\Pre-Reqs\poop2.txt" -Append
# Get-Date | Out-File -FilePath "C:\Users\user\Source\Repos\Azure_IaaS\Azure\Pre-Reqs\getdate.txt" -Append
# $InputParam | Out-File -FilePath "C:\Users\user\Source\Repos\Azure_IaaS\Azure\Pre-Reqs\poop3.txt" -Append
# Out-File -FilePath "C:\Users\user\Source\Repos\Azure_IaaS\Azure\Pre-Reqs\poop3.txt" -Append -InputObject $InputParam