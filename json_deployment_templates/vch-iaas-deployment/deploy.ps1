Set-Location -Path $PSScriptRoot
$template_path = Join-Path -Path $PSScriptRoot -ChildPath "template.json"
$template_path = "template.json"
$parameter_path = "azuredeploy.parameters.json"
# Login-AzureRmAccount
# Set-AzureRmContext -SubscriptionID {your-subscription-ID}

$Secret = Read-Host -AsSecureString -Prompt "Enter VM local admin password. `nIt will save/OVERWRITE secret: VmAdminPassword `nin Key vault: vchDsKeyVault"
# save pass word to Azure Key Vault
Set-AzureKeyVaultSecret -VaultName 'vchDsKeyVault' -Name 'VmAdminPassword' -SecretValue $Secret
# enable Key Vault for template deployment
Set-AzureRmKeyVaultAccessPolicy -VaultName 'vchDsKeyVault' -EnabledForTemplateDeployment

New-AzureRmResourceGroup -Name rg2 -Location "canadacentral"
Test-AzureRmResourceGroupDeployment -ResourceGroupName rg2 -TemplateFile $template_path -TemplateParameterFile $parameter_path -Verbose -Debug
New-AzureRmResourceGroupDeployment -Name gcdeployment -ResourceGroupName rg2 -TemplateFile $template_path -TemplateParameterFile $parameter_path
