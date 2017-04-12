# Linked json Template Deployment

Deployment template use these [design patterns](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates#capacity-and-capability-scoped-solution-templates) and follow these [best practices](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates)

## azuredeploy.json

- entry point of deployment
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