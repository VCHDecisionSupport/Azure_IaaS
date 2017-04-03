$PSScriptRoot
Set-Location -Path $PSScriptRoot

& '..\ConnectToSubscription.ps1'

& '.\Jump Box SubNet.ps1'

& '.\Active Directory Domain Controller SubNet.ps1'

& '.\Share Point SubNet.ps1'

& '.\Data Warehouse SubNet.ps1'

& '.\End User SubNet.ps1'


