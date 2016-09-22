Set-Location $PSScriptRoot
$configScripts=Get-ChildItem Pre-Reqs

foreach($script in $configScripts)
{
    $cmd=("{0}\Pre-Reqs\{1}" -f $PSScriptRoot, $script)
    Write-Host $cmd
    & $cmd
}