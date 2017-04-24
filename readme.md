# Azure_IaaS

## High Level Explanation

Azure resources (eg VMs, subnets, storage account etc) are configured/deployed using JSON template files and JSON parameter files.

- use parameter files to change what it deployed (do not edit templates)

- template files are not meant to change

## Deployed Infrastructure

- [resource group](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/infrastructure-resource-groups-guidelines#resource-groups)
- storage account
- [virtual network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- subnets
- virtual machines

- network security groups
- network interface cards
- public static ips
- private static ips

#### Post-Deployment Server Configuration

- Active Directory
  - install active directory and DNS server roles
  - create new domain forest with VM as domain controller
  - join other vms to domain

## __How to:__ Restore from VMs from images

todo

## __How to:__ Configure deployment

## Design Rationale
