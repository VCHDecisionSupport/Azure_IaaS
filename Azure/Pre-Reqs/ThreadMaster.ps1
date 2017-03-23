# each line of AllServers.txt is a parameter value sent ServerInfo.ps1

Set-Location $PSScriptRoot
# $X = (GC .\AllServers.txt)
# write-host $X
# write-host $X[1]
# write-host $X
.\Run-CommandMultiThreaded.ps1 -Command .\ServerInfo.ps1 -ObjectList ('a','b')