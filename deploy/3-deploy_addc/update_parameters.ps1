Set-Location -Path $PSScriptRoot

$automation_account_name = "vchds-auto"
$resource_group_name = "vchds-sp-test-rg"

$automation_account = Get-AzureRmAutomationAccount -ResourceGroupName $resource_group_name -Name $automation_account_name




$pathToJson = "param.json"
$a = Get-Content $pathToJson | ConvertFrom-Json
$a.parameters.dscRegistrationKey.value = "bob"
$a.parameters.dscRegistrationUrl.value = "jim"
$a | ConvertTo-Json | set-content $pathToJson