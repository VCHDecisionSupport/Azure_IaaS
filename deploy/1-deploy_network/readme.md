# 1-deploy_network

creates resources that will be used by all other resources

## Resources Deployed

1. new resource group
1. new storage account
1. new virtual network
    1. subnets in vnet

## Deployment Instrustions

execute PowerShell script: 1-deploy_network\deploy.ps1

## Code Explanation

### 1-deploy_network/deploy.ps1

1. Azure subscription login
    1. PowerShell cmdlet [`Add-AzureRmAccount`](https://docs.microsoft.com/en-us/powershell/module/azurerm.profile/add-azurermaccount?view=azurermps-3.8.0#description) 
        1. _Prompts an Azure account login popup (sometimes popup not in foreground, use **ALT + TAB**)._
1. Create new resource group with name `$resource_group_name` in location `$location`
    1. _PowerShell cmdlet [`New-AzureRmResourceGroup`](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-deploy) creates a new [Resource Group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview#resource-groups)_
1. Deploy template `azuredeploy_storage.json` using parameter values from `azuredeploy_storage.parameters.json`
    1. creates general purpose [Azure Storage Account](https://docs.microsoft.com/en-us/azure/storage/storage-introduction) for [File Share](https://docs.microsoft.com/en-us/azure/storage/storage-introduction#file-storage)
        1. _PowerShell cmdlet [`New-AzureRmResourceGroupDeployment`](https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroupdeployment?view=azurermps-3.8.0#description) initiates a new deployment of resources/configurations specified in the local template and parameter file specified in the arguements._
1. Deploy template `azuredeploy_vnet.json` using parameter values from `azuredeploy_vnet.parameters.json`
    1. creates a new [Virtual Network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) with [subnets](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-nsg#subnets) in the resource group.
        1. _PowerShell cmdlet [`New-AzureRmResourceGroupDeployment`](https://docs.microsoft.com/en-us/powershell/module/azurerm.resources/new-azurermresourcegroupdeployment?view=azurermps-3.8.0#description) initiates a new deployment of resources/configurations specified in the local template and parameter file specified in the arguements._

## Changing the deployment

`azuredeploy_storage.json` and `azuredeploy_vnet.json` can be reconfigured by changing parameter files `azuredeploy_storage.parameters.json` and `azuredeploy_vnet.parameters.json`.

## IMPORTANT: Resource dependencies

Most other resources (eg subnets, VMs) depend on these resources and their specific configuration which is set by the parameter files: `azuredeploy_storage.parameters.json` and `azuredeploy_vnet.parameters.json`.

Therefore, parameter values most be consistent between parameter files.
