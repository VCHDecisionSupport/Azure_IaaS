Set-Location -Path $PSScriptRoot
$template_path = Join-Path -Path $PSScriptRoot -ChildPath "template.json"
Login-AzureRmAccount
# Set-AzureRmContext -SubscriptionID {your-subscription-ID}
New-AzureRmResourceGroup -Name DevOpRg -Location "canadacentral"
New-AzureRmResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName DevOpRg -TemplateFile $template_path
