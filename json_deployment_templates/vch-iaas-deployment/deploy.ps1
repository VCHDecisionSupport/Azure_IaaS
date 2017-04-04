Set-Location -Path $PSScriptRoot
$template_path = Join-Path -Path $PSScriptRoot -ChildPath "template.json"
$template_path = "template.json"
# Login-AzureRmAccount
# Set-AzureRmContext -SubscriptionID {your-subscription-ID}
New-AzureRmResourceGroup -Name Bob5 -Location "canadacentral"
Test-AzureRmResourceGroupDeployment -ResourceGroupName Bob5 -TemplateFile $template_path -Verbose -Debug
New-AzureRmResourceGroupDeployment -Name Bob5 -ResourceGroupName Bob5 -TemplateFile $template_path
canadacentral