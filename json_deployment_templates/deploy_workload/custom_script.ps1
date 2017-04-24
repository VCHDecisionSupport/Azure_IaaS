$resource_group_name = "configrg"
$location = "canadacentral"
$template_path = "script_extension.json"
$vm_name = "configVm0"
$run_cmd = "custom_script_local.ps1"
$url = "https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/json_deployment_templates/deploy_workload/custom_script_local.ps1"

Set-AzureRmVMCustomScriptExtension -ResourceGroupName $resource_group_name `
    -VMName $vm_name `
    -Location $location `
    -FileUri $url `
    -Run $run_cmd `
    -Name DemoScriptExtension1