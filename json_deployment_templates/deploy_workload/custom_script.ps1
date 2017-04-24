$resource_group_name = "testrg"
$location = "canadacentral"
$template_path = "script_extension.json"
$vm_name = "addcVm1"
$run_cmd = "custom_script_local.ps1"
$url = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/json_deployment_templates/deploy_workload/custom_script_local.ps1"

Set-AzureRmVMCustomScriptExtension -ResourceGroupName $resource_group_name `
    -VMName myVM `
    -Location $location `
    -FileUri $url `
    -Run 'myScript.ps1' `
    -Name DemoScriptExtension