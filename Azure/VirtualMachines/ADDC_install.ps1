
Add-WindowsFeature AD-Domain-Services

# set up data disks and dirves...
Get-Disk | Where-Object IsSystem -eq $true
Get-Disk | Where-Object IsSystem -eq $false
# initialize disks
Initialize-Disk 2 –PartitionStyle MBR
Initialize-Disk 3 –PartitionStyle MBR
# add partition and disk drive letters

New-Partition –DiskNumber 2 -UseMaximumSize -AssignDriveLetter 
Get-Partition –DiskNumber 2

New-Partition –DiskNumber 3 -UseMaximumSize -AssignDriveLetter 
Get-Partition –DiskNumber 3


Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "Win2012R2" `
-DomainName "vch.ca" `
-DomainNetbiosName "VCH" `
-ForestMode "Win2012R2" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true