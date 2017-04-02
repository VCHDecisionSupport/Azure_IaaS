
Install-WindowsFeature -name AD-Domain-Services –IncludeManagementTools
Install-ADDSForest -DomainName corp.adatum.com -InstallDNS
Add-WindowsFeature  -IncludeManagementTools dhcp
