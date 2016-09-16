cd $PSScriptRoot
..\ConnectToSubscription.ps1

$autoAcct=Get-AzureRmAutomationAccount -ResourceGroupName $resourceGroupName -Name $autoAcctName
$FieldValues = @{"AutomationCertificateName"="AutoCertName";"SubscriptionID"=$sub.SubscriptionId}
$autoConName="AutoConn";
New-AzureRmAutomationConnection -ResourceGroupName $resourceGroupName -AutomationAccountName $autoAcctName -ConnectionTypeName "AzureServicePrincipal" -Description "gcwashere" -ConnectionFieldValues $FieldValues  -Name $autoConName 
