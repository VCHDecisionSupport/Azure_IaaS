
#########################################
# download git install media
#########################################

$url = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/powershell_utils/Init-FileShare.ps1"
$filename = $url.Split('/')[-1]
$save_dir = "$PSScriptRoot"
$save_path = Join-Path -Path $save_dir -ChildPath $filename

Write-Host "Downloading: $url to`n`t$save_path"
Invoke-WebRequest -Uri $url -OutFile $save_path

& ".\$filename"