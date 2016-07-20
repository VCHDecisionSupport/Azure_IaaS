Set-Location -Path $PSScriptRoot

$deployName="TestDeployment"

$RGName="VMResourceGroup"

$locname="canadaeast"

$templateFile=".\azuredeploy.json"

New-AzureRmResourceGroupDeployment -Name $deployName -ResourceGroupName $RGName -TemplateFile $templateFile
 