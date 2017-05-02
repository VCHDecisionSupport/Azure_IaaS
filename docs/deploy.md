# Deployment Walk-Through

see prereqs

## 1. Automation Account and Desired State Configuration

## 2. Network

## 3. Domain Controller and Active Directory Forest 




Assumes empty Azure subscription.

A "workload" is a set to related functionalities:

- Active Directory Domain Controller
- Share Point Farm
- Data Warehouse
- Jumpbox
- End users

## High Level Steps

1. initialize common powershell variable values (set `$env` global variable)
1. Create new resource group
1. Create virtual network
1. Create jumpbox subnet (allow http remote connections from internet)
1. Deploy jumpbox vm to subnet
1. Create active directory domain controller subnet (disallow connections from internet)
1. Deploy addc vm to subnet
1. remote into jumpbox vm
1. from jumpbox remote into addc vm
1. add addc windows feature
1. promote vm to be domain controller (vm auto restarts)
1. join jumpbox vm to domain
1. deploy data warehouse subnet and vms (join each vm to domain)
1. deploy sharepoint farm subnet and vms (join each vm to domain)

[join domain](https://blogs.msdn.microsoft.com/igorpag/2016/01/25/azure-arm-vm-domain-join-to-active-directory-domain-with-joindomain-extension/)


