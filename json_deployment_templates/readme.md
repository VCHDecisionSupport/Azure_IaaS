# Azure Resource Manager Templates

- Azure "resources" are specified using "templates"
- template files are written in declarative JSON syntax
- templates can define input parameters whose values are set in separate "parameter files"
- PowerShell commands send templates to the "Azure Resource Manager" service
- Azure Resource Manager provisions the resources

## Deployment steps


1. deploy shared resources (see `deploy_shared` folder)
1. deploy work load resources (see `deploy_workload` folder)
1. configure vm server roles (todo)

- shared permanent resources
  - virtual network
  - storage account
- disposible workload specific resources
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
- templates are deployments are started with PowerShell
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

## Resources

- [Azure Resource Manager overview](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview)
- [Resource Manager templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates)
- [Deploy template with PowerShell](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-deploy#deploy-local-template)
- [Template design patterns](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates)
- [Single template vs nested templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates)
- [technology specific environment](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates#common-template-scopes)
- [IP Calculator for calculating CIDR notation network prefixes](http://jodies.de/ipcalc)
