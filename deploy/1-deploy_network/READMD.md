# 2-deploy_network

creates resources that will be used by all other resources

to deploy execute `deploy.ps1`

1. new resource group
1. new storage account
1. new virtual network

## Logic walk through

1. `deploy.ps1`
    1. Azure subscription login
    1. Create new resource group
    1. Deploy template `azuredeploy_storage.json` using parameter values from `azuredeploy_storage.parameters.json`
    1. Deploy template `azuredeploy_vnet.json` using parameter values from `azuredeploy_vnet.parameters.json`

`azuredeploy_storage.json` creates new storage account in resource group.

`azuredeploy_vnet.json` creates new vnet account in resource group.

`azuredeploy_storage.json` and `azuredeploy_vnet.json` can be reconfigured by changing parameter files `azuredeploy_storage.parameters.json` and `azuredeploy_vnet.parameters.json`.

## IMPORTANT: Resource dependencies

Most other resources (eg subnets, VMs) depend on these resources and their specific configuration which is set by the parameter files: `azuredeploy_storage.parameters.json` and `azuredeploy_vnet.parameters.json`.

Therefore, parameter values most be consistent through out Azure environment.
