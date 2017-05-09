# 4-deploy_vms

Deploys factory default VMs to an already existing subnet.

## Deployment

execute PowerShell script: 4-deploy_vms\deploy.ps1

## Code explanation

see [issue #55: List of on prem harddrives](https://github.com/VCHDecisionSupport/Azure_IaaS/issues/55)

### Logic work through

1. `deploy_vms.ps1` deploys `azuredeploy_vms.json` using parameter file
    - creates 1 new public static ip (pip) for each VM
    - creates 1 new network interface card (nic) for each VM
        - associates nics to public ips (pip) and private ips
    - creates new VM(s)
        - create virtual hard disks (vhd) for OS and data
        - copy OS image (set in parameter file) to OS vhd
        - associates each vm to a nic

## Dependancies

- subnet
  - private ip must be in ip range of subnet
- storage account
  - OS and storage disks are provisioned to a storage account