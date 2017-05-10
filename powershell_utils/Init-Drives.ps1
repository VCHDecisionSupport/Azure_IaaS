


#########################################################################################
##########        Mount Azure File Share as S: Drive
#########################################################################################
$cmd = {
    Write-Host "

#########################################################################################`
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



#########################################################################################
##########        Initialize, Format Azure Data Disks
#########################################################################################


# https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#add-an-empty-data-disk-to-a-virtual-machine

# 1. 
# see uninit disks

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"


$cmd = {Get-PSDrive -PSProvider "FileSystem" | Format-Table  }
Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred

$cmd = {Get-Disk |Sort-Object Number | Format-Table }
Invoke-Command -ComputerName $comp -ScriptBlock $cmd -Credential $cred

Write-Host "--------------------------------------------`n$comp`n--------------------------------------------`n"



# 2.
# setup up config dict: {lun,{letter, label}}

# for spVm0, spVm1, spVm2
# $lun2drive = @{
#     2 = @{"letter" = "E"; 
#         "label" = ""
#     }
# }

# $drive_json = '
# {
#     "root":
#     {
#         "2": {
#             "letter":"E",
#             "label":"New Volume onprem D"
#         },
#         "3": {
#             "letter":"H",
#             "label":"Data onprem H"
#         },
#         "4": {
#             "letter":"I",
#             "label":"SQL_Temp"
#         },
#         "5": {
#             "letter":"J",
#             "label":"SQL_Temp"
#         },
#         "6": {
#             "letter":"K",
#             "label":"Kackup"
#         }
#     }
# }
# '
# $lun2drive = ConvertFrom-Json $drive_json
# $lun2drive

# # Read-Host "confirm..."

# foreach ($lun in ($lun2drive.root | Get-Member * -MemberType NoteProperty).Name) {
#     Write-Output "$lun = $($lun2drive.root.$lun)"
#     Write-Host $($lun2drive.root.$lun)
#     $drive_letter = $lun2drive.root.$lun.letter
#     $drive_label = $lun2drive.root.$lun.label
#     Write-Host "mapping ${drive_letter}"
#     Write-Host "mapping ${drive_label}"
    
#     $disk = Get-Disk -Number $lun
#     $disk
#     $disk |
#         Initialize-Disk -PartitionStyle MBR -PassThru |
#         New-Partition -UseMaximumSize -DriveLetter $drive_letter |
#         Format-Volume -FileSystem NTFS -NewFileSystemLabel $drive_label -Confirm:$false -Force
#     # New-Partition -UseMaximumSize -DriveLetter $drive_letter -DiskNumber $lun |
#     #     Format-Volume -FileSystem NTFS -NewFileSystemLabel $drive_label -Confirm:$false -Force
#     # Format-Volume -DriveLetter $drive_letter -Force
# }

# Get-PSDrive -PSProvider "FileSystem"