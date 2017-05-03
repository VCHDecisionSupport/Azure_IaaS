# ppbuak
# set current working directory
Set-Location -Path $PSScriptRoot


$resource_group_name = "vchds-sp-test-rg"


# Azure login; only need to login once per powershell session
# Login-AzureRmAccount

# update parameter file with Automation Account info
Write-Host "`n`nattempting to automatically update parameter file: dscRegistrationKey and dscRegistrationUrl"
Write-Host "connecting to automation account"
$automation_account_name = "vchds-auto"
$automation_account_info = Get-AzureRmAutomationRegistrationInfo -ResourceGroupName $resource_group_name -AutomationAccountName 
$pathToJson = "azuredeploy.parameters.json"
Write-Host "editting json file: ${pathToJson} in ${PSScriptRoot}"
$json = Get-Content $pathToJson | ConvertFrom-Json
$json.parameters.dscRegistrationKey.value = $automation_account_info.PrimaryKey
$json.parameters.dscRegistrationUrl.value = $automation_account_info.Endpoint
$json | ConvertTo-Json | set-content $pathToJson
Write-Host "`nparameter file updated`n"


# deploy resources declared in $template_path
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$deployment_name = "addcDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path