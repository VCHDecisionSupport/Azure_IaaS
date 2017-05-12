# Azure_IaaS

In [Azure Resource Manager](#azure-resource-manager-and-template-docs), deploy-able objects (eg virtual network, virtual machine) are called _resources_.  Each resource has a name (eg "vchds-sp-test-vnet", "dcVm0") and belongs to a [_resource group_](#resource-specific-documentation) which also has a name.  Resources can be declared using [JSON deployment templates](#azure-resource-manager-and-template-docs) and deployed into an Azure resource group with the PowerShell cmdlet [`New-AzureRmResourceGroupDeployment`](#azure-resource-manager-and-template-docs).

## Table of Contents

<!-- TOC -->

- [Azure_IaaS](#azure_iaas)
    - [Table of Contents](#table-of-contents)
    - [Adminstration](#adminstration)
        - [Overview of Azure management websites](#overview-of-azure-management-websites)
        - [Azure Admin/Dev Prerequisites](#azure-admindev-prerequisites)
            - [Accounts and permissions](#accounts-and-permissions)
            - [Workstation upgrades and software](#workstation-upgrades-and-software)
    - [Deployment steps](#deployment-steps)
    - [VCH Azure Infrastructure](#vch-azure-infrastructure)
    - [IaaS resources docs](#iaas-resources-docs)
        - [Comparison and cloud service models](#comparison-and-cloud-service-models)
        - [Resource Specific Documentation](#resource-specific-documentation)
    - [Other useful documentation](#other-useful-documentation)
        - [Azure quick start templates examples (GitHub)](#azure-quick-start-templates-examples-github)
        - [Azure Resource Manager and template docs](#azure-resource-manager-and-template-docs)
        - [Backup/restore](#backuprestore)
        - [Active Directory Domain Services](#active-directory-domain-services)
        - [Desired State Configuration](#desired-state-configuration)
        - [PowerShell for Azure](#powershell-for-azure)
        - [PluralSight Courses:](#pluralsight-courses)
        - [misc](#misc)
            - [On-premises Active Directory Domain Controller install/config](#on-premises-active-directory-domain-controller-installconfig)

<!-- TOC -->

## On-Prem to Azure Mappings

### Servers

#### SPSPSFE11 ()

## Adminstration

### Overview of Azure management websites

see here for the hierarchy of [Azure Enterprise management](https://marckean.com/2016/06/03/azure-enterprise-enrollment-hierarchy/)

- [ea.azure.com](https://ea.azure.com/): **Enterprise Portal**
  - Alan is (Enterprise) Account Administrator
  - create new subscription and assign "Service Administrator" to manage/administer it
- [portal.azure.com](https://portal.azure.com/)  **Azure Portal**
  - provision new resources to Azure
    - resource group, vnet, VMs
  - manage existing resources
    - stop/start VMs
    - backup/restore VMs
  - manage permissions to your subscriptions
- [account.windowsazure.com](https://account.windowsazure.com/)
  - review subscription fees and bills
  - manage your azure login/profile

### Azure Admin/Dev Prerequisites

#### Accounts and permissions

- [Microsoft Live account](https://signup.live.com) with permission on [Azure subscription](https://portal.azure.com/)
  - Subscription administrator (ie "Service Administrator") must grant this permission
- [Github account](https://github.com/join) with membership in [VCHDecisionSupport](https://github.com/orgs/VCHDecisionSupport/people)

#### Workstation upgrades and software

- [Azure PowerShell Upgrade (Windows Management Framework 5.0)](https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-3.8.0) extension installed 
- [Github Client for Windows](https://desktop.github.com/) 
- [VS Code IDE](https://code.visualstudio.com/) 

## Deployment steps

see folder: [deploy](https://github.com/VCHDecisionSupport/Azure_IaaS/tree/master/deploy#azure-resource-manager-deployments)

## VCH Azure Infrastructure

[![](https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/docs/network_diagram.png "2 tier Architecture with Jumpbox by Renee Fung (click for docs)")](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/virtual-machines-windows/n-tier)

## IaaS resources docs

- [Start Azure IaaS Learning Here](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview)
- [Full IaaS walk through](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/infrastructure-example?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json)

### Comparison and cloud service models

[![](https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/docs/CloudPlatforms.png "2 tier Architecture with Jumpbox by Renee Fung (click for docs)")](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/virtual-machines-windows/n-tier)

### Resource Specific Documentation

- [resource group](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/infrastructure-resource-groups-guidelines#resource-groups)
- [storage account](https://docs.microsoft.com/en-us/azure/storage/storage-introduction#blob-storage)
- [automation account](https://kvaes.wordpress.com/2017/04/29/azure-deploying-a-domain-controller-via-dsc-pull/)
- [virtual network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
  - [subnets](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-nsg/#subnets)
    - [network security groups](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-nsg)
    - [virtual machines](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/)
      - [network interface cards](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview#a-namewithin-vnetaconnect-azure-resources)
        - [public static ips](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-public-ip-address)
        - [private static ips](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-static-private-ip-arm-pportal)

## Other useful documentation

### Azure quick start templates examples (GitHub)

- [3 vm SharePoint Farm](https://github.com/VCHDecisionSupport/azure-quickstart-templates/tree/master/sharepoint-three-vm)
- [new AD Forest, Domain, and DC](https://github.com/Azure/azure-quickstart-templates/tree/master/active-directory-new-domain)
- [join existing domain](https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-domain-join-existing/azuredeploy.json)
- [dynamic data disks](https://github.com/Azure/azure-quickstart-templates/blob/master/201-vm-dynamic-data-disks-selection/azuredeploy.json)

Also see [devtestlab templates](https://github.com/Azure/azure-devtestlab/tree/master/Samples) (auto shut down, auto start etc)

### Azure Resource Manager and template docs

- [Azure Resource Manager overview](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview)
- [Resource Manager templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates)
- [Deploy template with PowerShell](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-deploy#deploy-local-template)
- [Template design patterns](https://docs.microsoft.com/en-us/azure/azure-resource-manager/best-practices-resource-manager-design-templates)
- [Template functions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-functions)
- [Custom script extension](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/extensions-customscript)
- [Single template vs nested templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates)

### Backup/restore

- [Mount Azure File Share As Network Drive](https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-how-to-use-files#mount-the-file-share)
 -[Attach and initialize data disk to a drive letter on VM](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#add-an-empty-data-disk-to-a-virtual-machine)
- [How to capture a VM image](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/capture-image)
- [Domain controller VMs cannot be captured (`sysprep` not supported)](https://msdn.microsoft.com/windows/hardware/commercialize/manufacture/desktop/sysprep-support-for-server-roles)

### Active Directory Domain Services

- [**Walk through Active Directory on Azure via DSC**](https://kvaes.wordpress.com/2017/04/29/azure-deploying-a-domain-controller-via-dsc-pull/)
- [xActiveDirectory Desired State Configuration for Azure Automation](https://www.powershellgallery.com/packages/xActiveDirectory)

### Desired State Configuration

- [List of learning resources](http://dille.name/blog/2014/12/10/useful-resources-to-teach-yourself-powershell-dsc/)

### PowerShell for Azure

- [Manage VMs with PowerShell](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-manage/)
- [Add data disk to VM](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#add-an-empty-data-disk-to-a-virtual-machine)
- [Configure Remote Azure VM PowerShell Access with PowerShell](http://fabriccontroller.net/automatically-configuring-remote-powershell-for-windows-azure-virtual-machines-on-your-machine/)
- [Configure Remote Azure VM PowerShell Access](https://blogs.msdn.microsoft.com/mariok/2011/08/08/command-line-access-to-azure-vms-powershell-remoting/)
- [PowerShell script to Configure Secure Remote PowerShell Access to Windows Azure Virtual Machines](https://gallery.technet.microsoft.com/scriptcenter/Configures-Secure-Remote-b137f2fe)
- [Introduction to Remote PowerShell with Windows Azure](https://www.opsgility.com/blog/windows-azure-powershell-reference-guide/introduction-remote-powershell-with-windows-azure/)

### PluralSight Courses:

- [Managing Infrastructure with Microsoft Azure - Getting Started](https://www.pluralsight.com/courses/managing-infrastructure-microsoft-azure-getting-started)
- [Microsoft Azure Virtual Machines - Getting Started](https://www.pluralsight.com/courses/azure-vms-getting-started)

### misc

- [Azure VM sizing](https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/)
- [IP Calculator for calculating CIDR notation network prefixes](http://jodies.de/ipcalc)

#### On-premises Active Directory Domain Controller install/config

These explain local (on premises) new forest install well

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
