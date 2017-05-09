# https://www.howtogeek.com/117192/how-to-run-powershell-commands-on-remote-computers/

$cmd = {
    $drive_letter = "S:"
    $share_display_root = "\\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare"
    $ps_drive = Get-PSDrive -PSProvider "FileSystem" | Where-Object {$_.DisplayRoot -eq $share_display_root}
    Write-Host $ps_drive
    if ($ps_drive -eq $null) {
        Write-Host "$share_display_root is NOT MOUNTED ${drive_letter}:"
        # cmdkey /add:vchdsgeneralstorage.file.core.windows.net /user:AZURE\vchdsgeneralstorage /pass:ZYLpWwtoR9Pn7gftHom21gJXDjhFtnrJqQJsDLMBiv2fOsfefrg86En0T5PkC7RInsqsPDyXKr4l/N542nhYJQ==
        # net use $drive_letter \\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare
    }
    else {
        Write-Host "$share_display_root is ALREADY mounted to ${drive_letter}:"
    }
}

$pass = ConvertTo-SecureString "Floater1" -AsPlainText -Force
$user = "spVm2"
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $pass

Invoke-Command -ComputerName "spVm2" -ScriptBlock $cmd -Credential $cred
Invoke-Command -ComputerName "spVm2" -ScriptBlock {Get-PSDrive -PSProvider "FileSystem" | Where-Object {$_.DisplayRoot -eq $share_display_root}} -Credential $cred