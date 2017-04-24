# Azure Resource Manager Templates

- Azure "resources" are specified using "templates"
- template files are written in declarative JSON syntax
- templates can define input parameters whose values are set in separate "parameter files"
- PowerShell commands send templates to the "Azure Resource Manager" service
- Azure Resource Manager provisions the resources

sdf



## Azure Deployment using JSON Templates

let you declare what resources are to be deployed

- templates parameters reduce configuration effort
- templates can be nested and execute one another
- templates are deployments are started with PowerShell
- templates follow [infrastructure as code](https://en.wikipedia.org/wiki/Infrastructure_as_Code)
  - version-able
  - repeatable
  - scalable

## deployment steps

There are two stages for a complete deployment

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




## resource hierarchy

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
- [Single template vs nested templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates)
- [Design patterns for Azure Resource Manager templates when deploying complex solutions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates)
- [IP Calculator for calculating CIDR notation network prefixes](http://jodies.de/ipcalc)


# Azure JSON Deployment Templates

## Walk Through

1. PowerShell script: `deploy.ps1`



## Capability Scope Topology

Since requirements call for complex multi-tier infrastructure design of deployment templates use [nested templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates) to reduce code duplication and promote simplicity.

Since design goal is a [technology specific environment](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates#common-template-scopes), the [capability scope topology design pattern](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates#capacity-and-capability-scoped-solution-templates) was adopted.


## azuredeploy.json

- main entry point of deployment
- receives parameter values from user provided parameter file



- creates one-off resources

### what it includes and does

- spec data centre location
- create resource group
- create storage account
- create virtual network
  - spec dsn server ip (actual server deployed by linked child template)

it then specifies workloads that are required

- spec workload name
  - spec create subnet name
  - spec subnet ip range
  - spec subnet net security groups
- spec number of vms
- spec vm size

these parameter sets for each workload are sent to a linked child template: _template_workload.json_ which actually creates required resources

## template_workload.json

- linked template (child to _azuredeploy.json_)
- creates resources required for a single workload

### what it includes and does

- creates subnet in vnet
- create network security group and rules
- create vm(s)
  - create network interface card
    - create public static ip
    - create private static ip in subnet