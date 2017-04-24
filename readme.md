# Azure_IaaS

Azure resources (eg VMs, subnets, storage account etc) are configured/deployed using JSON template files and JSON parameter files.

- use parameter files to change what it deployed (do not edit templates)
- template files are not meant to change

## Deployment steps

deployment code located in `/json_deployment_templates/` folder in repo root

1. deploy shared resources (see `deploy_shared` folder)
1. deploy work load resources (see `deploy_workload` folder)
1. configure vm server roles (todo)

### Network Diagram

[![](https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/notes/network_diagram.png "2 tier Architecture with Jumpbox by Renee Fung (click to see tutorial)")](https://azure.microsoft.com/en-us/documentation/articles/guidance-compute-3-tier-vm/)

### Post-deployment server configuration

- Active Directory
  - install active directory and DNS server roles
  - create new domain forest with VM as domain controller
  - set vnet dns server
  - join other vms to domain

## Deployed resources and docs

- [resource group](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/infrastructure-resource-groups-guidelines#resource-groups)
- [storage account](https://docs.microsoft.com/en-us/azure/storage/storage-introduction#blob-storage)
- [virtual network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [subnets](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-nsg/#subnets)
  - [network security groups](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-nsg)
- [virtual machines](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/)
  - [network interface cards](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview#a-namewithin-vnetaconnect-azure-resources)
  - [public static ips](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-public-ip-address)
  - [private static ips](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-static-private-ip-arm-pportal)

## Technical documentation and tutorials

### Azure resource manager templates

- [Azure Resource Manager overview](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview)
- [Resource Manager templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates)
- [Deploy template with PowerShell](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-deploy#deploy-local-template)
- [Template design patterns](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates)
- [Single template vs nested templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates)
- [technology specific environment](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates#common-template-scopes)
- [IP Calculator for calculating CIDR notation network prefixes](http://jodies.de/ipcalc)

### Active Directory Domain Services

These explain new forest deployment well
- [Setting up Active Directory with PowerShell](https://blogs.technet.microsoft.com/uktechnet/2016/06/08/setting-up-active-directory-via-powershell/) 
- [Deploying Windows Server 2012 and Windows Server 2012 R2 Domain Controllers](https://www.microsoftpressstore.com/articles/article.aspx?p=2216997&seqNum=4)
- [Install a New Windows Server 2012 Active Directory Forest (Level 200)](https://technet.microsoft.com/windows-server-docs/identity/ad-ds/deploy/install-a-new-windows-server-2012-active-directory-forest--level-200-)
- [Install Active Directory Domain Services (Level 100)](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-)

[Change IP used for DNS Lookups with wizard](http://geekswithblogs.net/technetbytes/archive/2011/10/09/147233.aspx)

Classic deployment model but includes links to other topics (domain trusts)

[Install a new Active Directory forest on an Azure virtual network](https://azure.microsoft.com/en-us/documentation/articles/active-directory-new-forest-virtual-machine/)

DHCP server role is not needed but just in case...
- [Azure Name Resolution](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
- [Installing and Configuring DHCP role on Windows Server 2012](https://blogs.technet.microsoft.com/teamdhcp/2012/08/31/installing-and-configuring-dhcp-role-on-windows-server-2012/)
- [Bringing PowerShell to DHCP Server](https://blogs.technet.microsoft.com/teamdhcp/2012/07/15/bringing-powershell-to-dhcp-server/)


### PowerShell for Azure <b id="f10"></b>[↩](#a10)

[Manage VMs with PowerShell](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-manage/)

[Configure Remote Azure VM PowerShell Access with PowerShell](http://fabriccontroller.net/automatically-configuring-remote-powershell-for-windows-azure-virtual-machines-on-your-machine/)

[Configure Remote Azure VM PowerShell Access](https://blogs.msdn.microsoft.com/mariok/2011/08/08/command-line-access-to-azure-vms-powershell-remoting/)

[PowerShell script to Configure Secure Remote PowerShell Access to Windows Azure Virtual Machines](https://gallery.technet.microsoft.com/scriptcenter/Configures-Secure-Remote-b137f2fe)

[Introduction to Remote PowerShell with Windows Azure](https://www.opsgility.com/blog/windows-azure-powershell-reference-guide/introduction-remote-powershell-with-windows-azure/)

## Other documentation:

[Azure VM sizing](https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/)

[Create DNS Zone](https://azure.microsoft.com/en-us/documentation/articles/dns-getstarted-create-dnszone/)
