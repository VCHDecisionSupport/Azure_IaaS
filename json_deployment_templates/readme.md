# Azure Resource Manager Templates

- Azure "resources" are specified using "templates"
- template files are written in declarative JSON syntax
- templates can define input parameters whose values are set in separate "parameter files"
- PowerShell commands send templates to the "Azure Resource Manager" service
- Azure Resource Manager provisions the resources

## Deployment steps


1. deploy shared resources (see [deploy_shared](deploy_shared) folder)
  - virtual network
  - storage account
1. deploy work load resources (see [deploy_workload](deploy_workload) folder)
- disposable workload specific resources
  - subnet
    - network security group
    - virtual machine(s)
      - hard drives
        - os disk
        - data disk(s)
      - network interface card
      - public static ip
      - private/local static ip
1. configure vm server roles (todo)

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

