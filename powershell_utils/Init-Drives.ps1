#########################################################################################
##########        Mount Azure File Share as S: Drive
#########################################################################################
$cmd = {
    $drive_letter = "S:"
    $share_display_root = "\\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare"
    $ps_drive = Get-PSDrive -PSProvider "FileSystem" | Where-Object {$_.DisplayRoot -eq $share_display_root}
    Write-Host $ps_drive
    if ($ps_drive -eq $null) {
        Write-Host "MOUNTING $share_display_root to ${ps_drive}:"
        cmdkey /add:vchdsgeneralstorage.file.core.windows.net /user:AZURE\vchdsgeneralstorage /pass:ZYLpWwtoR9Pn7gftHom21gJXDjhFtnrJqQJsDLMBiv2fOsfefrg86En0T5PkC7RInsqsPDyXKr4l/N542nhYJQ==
        net use $drive_letter \\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare
    }
    else 
    {
        Write-Host "$share_display_root is ALREADY mounted to ${ps_drive}:"
    }
}

Invoke-Command -ScriptBlock $cmd



#########################################################################################
##########        Initialize, Format Azure Data Disks
#########################################################################################


# https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#add-an-empty-data-disk-to-a-virtual-machine


# 1. see uninit disks
$disks = Get-Disk | Where partitionstyle -Like 'raw' | sort number
$disks
Get-PSDrive -PSProvider "FileSystem"



# setup up config dict: {lun,{letter, label}}
# for spVm0, spVm1, 
$lun2drive = @{
    2 = @{"letter" = "E"; 
        "label" = ""
    }
}

$lun2drive

Read-Host "confirm..."

foreach ($lun in $lun2drive.Keys) {
    Write-Host "mapping ${lun2drive[$lun]}"
    $drive_letter = $lun2drive[$lun]["letter"]
    $drive_label = $lun2drive[$lun]["label"]
    $disk = Get-Disk -Number $lun
    $disk |
    Initialize-Disk -PartitionStyle MBR -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $drive_letter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel $drive_label -Confirm:$false -Force
}

Get-PSDrive -PSProvider "FileSystem"