# Deploy_workload

- VMs are organized into logical "workloads" (ie SharePoint, Active Directory, Data warehouse, etc)
- each workload is deployed into a separate subnet within the virtual network

to deploy a new workload

1. execute `deploy_subnet.ps1` (creates new subnet in vnet)
1. execute `deploy_vms.ps1` (creates VM(s) in subnet)

## `deploy_subnet.ps1`

**Depends on**

- virtual network
    - subnet ip range must be in ip range of vnet

### Logic work through

1. `deploy_subnet.ps1`
    - creates new subnet in virtual network
    - creates new network security group (nsg) for subnet

## `deploy_vms.ps1`

**Depends on**

- subnet
    - private ip must be in ip range of subnet
- storage account
    - OS and storage disks are provisioned to a storage account

### Logic work through

1. `deploy_vms.ps1` deploys `azuredeploy_vms.json` using parameter file 
    - creates 1 new public static ip (pip) for each VM
    - creates 1 new network interface card (nic) for each VM
        - associates nics to pips and private ips
    - creates new VM(s)
        - create virtual hard disks (vhd) for OS and data
        - copy OS image (set in parameter file) to OS vhd
        - associates each vm to a nic
