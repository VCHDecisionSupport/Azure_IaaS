Set-Location -Path $PSScriptRoot
$template_path = Join-Path -Path $PSScriptRoot -ChildPath "template.json"
$template_path = "template.json"
Login-AzureRmAccount
# Set-AzureRmContext -SubscriptionID {your-subscription-ID}
New-AzureRmResourceGroup -Name rg1 -Location "canadacentral"
Test-AzureRmResourceGroupDeployment -ResourceGroupName rg1 -TemplateFile $template_path -Verbose -Debug
New-AzureRmResourceGroupDeployment -Name rg1 -ResourceGroupName rg1 -TemplateFile $template_path