Set-Location -Path $PSScriptRoot
$template_path = Join-Path -Path $PSScriptRoot -ChildPath "template.json"
$template_path = "template.json"
# Login-AzureRmAccount
# Set-AzureRmContext -SubscriptionID {your-subscription-ID}
# New-AzureRmResourceGroup -Name DevOpRg -Location "canadacentral"
Test-AzureRmResourceGroupDeployment -ResourceGroupName DevOpRg -TemplateFile $template_path
# New-AzureRmResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName DevOpRg -TemplateFile $template_path
