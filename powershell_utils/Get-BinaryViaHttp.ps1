
#########################################
# download git install media
#########################################

$url = "https://github.com/git-for-windows/git/releases/download/v2.13.0.windows.1/Git-2.13.0-64-bit.exe"
$filename = $url.Split('/')[-1]
$save_dir = "$PSScriptRoot"
$save_path = Join-Path -Path $save_dir -ChildPath $filename

Write-Host "Downloading: $url to $save_path"
# Write-Host $filename
# Write-Host $save_dir
# Write-Host $save_path


$start_time = Get-Date
# Invoke-WebRequest -Uri $url -OutFile $save_path
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#########################################
# unattended install git
# https://github.com/msysgit/msysgit/wiki/Silent-or-Unattended-Installation
#########################################

$install_cmd =".\$filename /SILENT /COMPONENTS=""icons,ext\reg\shellhere,assoc,assoc_sh"""

Invoke-Expression $install_cmd -