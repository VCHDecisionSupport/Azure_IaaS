# Azure Resource Manager Deployments

## Templates

Templates typically provision empty/unconfigured infracture: vnet, factory default vm.

- Azure infrastructure "resources" (eg vnet, vm) are specified (eg vnet ip range, vm os) using "templates"
- template files are written in declarative JSON syntax
- templates can define input parameters whose values are set in separate "parameter files"
- PowerShell cmdlet `New-AzureRmResourceGroupDeployment` sends templates to the "Azure Resource Manager" service
- Azure Resource Manager provisions the resources

Note: To monitor deployment progress/status/history of a resource group [see here](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-deployment-operations)

## Virtual Machine Extensions

Azure **virtual machine extensions** are small applications that provide post-deployment configuration and automation tasks on Azure virtual machines.

### Desired State Configuration

Desired state configuraton allows you declare a desired server configuration (eg install DC server role with domain vch.ca) for one or more servers under your administration.  In Azure, configuration files (and the module required to realize them) are uploaded to an Automation Account.  Then VMs are registered to the account.  Any changes to a server's Desired State Configuation are applied automatically.

VMs subscribe to a Desired State Configuration using the `Microsoft.Powershell.DSC` extension which is applied to VMs using code in [2-deploy_automation](\2-deploy_automation\readme.md)

## Deployment steps

see readmes in subfolders

### resource hierarchy

Use resource hierarchy to name by naming child resources as parent resources with an addition suffix/prefix.
I invented the concept of a "workload" to a describe group of vms in a single subnet that together.

- location
  - storage account
  - resource group
    - vnet
      - dsn server
      - domain
      - [workload]
        - subnet
          - nsg
          - [vm]
            - nic
              - public ip
            - os
            - size

