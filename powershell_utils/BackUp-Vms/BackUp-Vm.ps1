Set-Location -Path $PSScriptRoot
$resource_group_name = "backup-rg-ps"
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$location = "canadacentral"
$deployment_name = "addcDeployment"


# Login-AzureRmAccount

# Register-AzureRmResourceProvider -ProviderNamespace "Microsoft.RecoveryServices"