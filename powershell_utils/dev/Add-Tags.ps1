# https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags
$raw_json = '
{
    "spVm0": {
        "OnPrem":"SPSPSFE11",
        "Role":""
    },
    "spVm1": {
        "OnPrem":"SPSPSFE12"
    },
    "spVm2": {
        "OnPrem":"SPSPSFE13"
    },    
    "spVm3": {
        "OnPrem":"SPDBSS008"
    }
}
'

$json_tags = ConvertFrom-Json -InputObject $raw_json
$json_tags | Get-Member * -MemberType NoteProperty | Write-Host

foreach($vm_name in $json_tags)
{
    Write-Host $vm_name
    Write-Host $json_tags.$vm_name
    Write-Host $json_tags.$vm_name.OnPrem
    Write-Host $json_tags.$vm_name.Role
}

$resource_group_name = "vchds-sp-rg"
$vm_name = "spVm0"

$vm = Get-AzureRmVM -ResourceGroupName $resource_group_name -Name $vm_name
# $tags = $vm.Tags
# $tags += @{OnPrem=""}

# Set-AzureRmResource -Tag @{ Dept = "IT"; Environment = "Test" } -ResourceName storageexample -ResourceGroupName TagTestGroup -ResourceType Microsoft.Storage/storageAccounts
