# https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#add-an-empty-data-disk-to-a-virtual-machine


# 1. see uninit disks
$disks = Get-Disk | Where partitionstyle -Like 'raw' | sort number
$disks

# setup up config dict: {lun,{letter, label}}
$lun2drive = @{
    2 = @{"letter" = "F"; 
        "label" = "data disk"
    }
}

$lun2drive

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