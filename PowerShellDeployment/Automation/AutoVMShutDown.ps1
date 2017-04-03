cd $PSScriptRoot
..\ConnectToSubscription.ps1

$autoAcct=Get-AzureRmAutomationAccount -ResourceGroupName $env:resourceGroupName -Name $autoAcctName
$FieldValues = @{"AutomationCertificateName"="AutoCertName";"SubscriptionID"=$sub.SubscriptionId}
$autoConName="AutoConn";
New-AzureRmAutomationConnection -ResourceGroupName $env:resourceGroupName -AutomationAccountName $autoAcctName -ConnectionTypeName "AzureServicePrincipal" -Description "gcwashere" -ConnectionFieldValues $FieldValues  -Name $autoConName 
