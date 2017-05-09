# ppbuak
# set current working directory
Set-Location -Path $PSScriptRoot

$resource_group_name = "vchds-sp-rg"
$automation_account_name = "vchds-auto"
$vnet_name = "vchds-sp-vnet"
$dc_vm_name = "dcVm0"

# Azure login; only need to login once per powershell session
# Add-AzureRmAccount

# update parameter file with Automation Account info
Write-Host "`n`nattempting to update parameter file values from Azure: dscRegistrationKey and dscRegistrationUrl"
Write-Host "connecting to automation account"
$automation_account_info = Get-AzureRmAutomationRegistrationInfo -ResourceGroupName $resource_group_name -AutomationAccountName $automation_account_name
$pathToJson = "azuredeploy.parameters.json"
Write-Host "editting json file: ${pathToJson} in ${PSScriptRoot}"
$json = Get-Content $pathToJson | ConvertFrom-Json
$json.parameters.dscRegistrationKey.value = $automation_account_info.PrimaryKey
$json.parameters.dscRegistrationUrl.value = $automation_account_info.Endpoint
$json | ConvertTo-Json -Depth 10 | set-content $pathToJson
Write-Host "`nparameter file updated`n"


# deploy resources declared in $template_path
$template_path = "azuredeploy.json"
$parameter_path = "azuredeploy.parameters.json"
$deployment_name = "dcDeployment"
Write-Host ("Testing deployment of template:`n`t{0}" -f $template_path)
Test-AzureRmResourceGroupDeployment -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path
Write-Host ("Deploying of template:`n`t{0}" -f $template_path)
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_path -TemplateParameterFile $parameter_path



# get private ip on DC VM:
$vm = (Get-AzureRmVM -ResourceGroupName $resource_group_name -Name $dc_vm_name)[0]
$nic = Get-AzureRmNetworkInterface -ResourceGroupName $resource_group_name | Where-Object {$_.VirtualMachine.Id -eq $vm.Id}
$ip = ($nic.IpConfigurations).PrivateIpAddress
Write-Host ("changing vnet DNS server to IP address of DC ($dc_vm_name): $ip")
# get vnet DHCP Option: DNS Server
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resource_group_name -Name $vnet_name
$vnet.DhcpOptions.DnsServers = @($ip)
# save changes/update vnet
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

Write-Host "restarting active directory domain controller vm: $dc_vm_name"
Restart-AzureRmVM -ResourceGroupName $resource_group_name -Name $dc_vm_name
Write-Host "restarting active directory domain controller vm: $dc_vm_name"
Restart-AzureRmVM -ResourceGroupName $resource_group_name -Name $dc_vm_name