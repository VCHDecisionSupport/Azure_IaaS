$PWord = ConvertTo-SecureString –String "Floater1" –AsPlainText -Force
$username = "vch\dcVm0"
$Credential = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $username, $PWord
Add-Computer -ComputerName $env:COMPUTERNAME -DomainName "vch.ca" -Credential $Credential