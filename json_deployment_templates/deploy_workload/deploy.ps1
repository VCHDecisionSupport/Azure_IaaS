# https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm
# https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-dynamic-data-disks-selection/azuredeploy.json
# set current working directory
Set-Location -Path $PSScriptRoot
$resource_group_name = "testrg"

# prompts login popup; only need to login once per powershell session
# Login-AzureRmAccount

# deploy resources declared in $template_path
$template_path = "azuredeploy_workload.json"
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path
New-AzureRmResourceGroupDeployment -Name sharedResourcesDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path

Set-AzureRmVMCustomScriptExtension -ResourceGroupName $resource_group_name -Location "canadacentral" -VMName "addcVm0" -Name "ContosoTest" -TypeHandlerVersion "1.1" -StorageAccountName "Contoso" -StorageAccountKey <StorageKey> -FileName "configure_vm.ps1" -ContainerName "Scripts"