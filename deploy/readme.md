# Azure Resource Manager Deployments

## Templates

Templates typically provision empty/unconfigured infracture: vnet, factory default vm.

- Azure infrastructure "resources" (eg vnet, vm) are specified (eg vnet ip range, vm os) using "templates"
- template files are written in declarative JSON syntax
- templates can define input parameters whose values are set in separate "parameter files"
- PowerShell cmdlet `New-AzureRmResourceGroupDeployment` sends templates to the "Azure Resource Manager" service
- Azure Resource Manager provisions the resources

## Virtual Machine Extensions

Azure **virtual machine extensions** are small applications that provide post-deployment configuration and automation tasks on Azure virtual machines.

### Desired State Configuration

Desired state configuraton allows you declare a desired server configuration (eg install DC server role with domain vch.ca) for one or more servers under your administration.  In Azure, configuration files (and the module required to realize them) are uploaded to an Automation Account.  Then VMs are registered to the account.  Any changes to a server's Desired State Configuation are applied automatically.

VMs subscribe to a Desired State Configuration using the `Microsoft.Powershell.DSC` extension which is applied to VMs using code in [2-deploy_automation](.\2-deploy_automation\)

## Deployment steps

### 1. deploy shared resources (see [deploy_shared](deploy_shared) folder)

deploys these resources into the given resource group

- virtual network
- storage account

### 2. deploy work load resources (see [deploy_workload](deploy_workload) folder)

There are 5 workloads deployed into the given resource group.  each deployed into it's own subnet within the vnet.

- active directory
- share point
- data warehouse
- jumpbox
- end users

Each work load consists of:

- subnet
  - network security group
  - virtual machine(s)
    - hard drives
      - os disk
      - data disk(s)
    - network interface card
    - public static ip
    - private/local static ip

## Azure deployment using JSON templates

let you declare what resources are to be deployed

- templates parameters reduce configuration effort
- templates can be nested and execute one another
- templates follow [infrastructure as code](https://en.wikipedia.org/wiki/Infrastructure_as_Code)
  - version-able
  - repeatable
  - scalable

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

