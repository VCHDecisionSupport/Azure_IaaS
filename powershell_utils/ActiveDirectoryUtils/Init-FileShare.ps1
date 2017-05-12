

#########################################################################################
##########        Mount Azure File Share as S: Drive
#########################################################################################
$cmd = {
    Write-Host "#########################################################################################`
##########        Mount Azure File Share as S: Drive`
#########################################################################################`
"
    $drive_letter = "S:"
    $share_display_root = "\\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare"
    Get-PSDrive -PSProvider "FileSystem" | Where-Object {$drive_letter -icontains $_.Name} | Format-Table 
    $ps_drive = (Get-PSDrive -PSProvider "FileSystem").Name | Where-Object {$drive_letter[0] -like $_}
    if ($ps_drive -eq $null) {
        Write-Host "MOUNTING $share_display_root to ${drive_letter}"
        cmdkey /add:vchdsgeneralstorage.file.core.windows.net /user:AZURE\vchdsgeneralstorage /pass:ZYLpWwtoR9Pn7gftHom21gJXDjhFtnrJqQJsDLMBiv2fOsfefrg86En0T5PkC7RInsqsPDyXKr4l/N542nhYJQ==
        net use $drive_letter \\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare
    }
    else {
        Write-Host "$share_display_root is ALREADY mounted to ${ps_drive}:"
    }
}

Invoke-Command -ScriptBlock $cmd
