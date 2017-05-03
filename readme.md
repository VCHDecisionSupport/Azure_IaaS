# Azure_IaaS




Azure resources (eg VMs, subnets, storage account etc) are configured/deployed using JSON template files and JSON parameter files.

- use parameter files to change what it deployed (do not edit templates)
- template files are not meant to change

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FVCHDecisionSupport%2FAzure_IaaS%2Fmaster%2Fjson_deployment_templates%2Fdeploy_sharepoint%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

## Deployment steps

1. setup automation account
1. create vnet and subnets
1. deploy and configure AD and DC

deployment code located in [json_deployment_templates](json_deployment_templates) folder in repo root

1. deploy shared resources (see [deploy_shared](json_deployment_templates/deploy_shared) folder)
1. deploy work load resources (see [deploy_workload](json_deployment_templates/deploy_workload) folder)

### Network diagram

[![](https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/docs/network_diagram.png "2 tier Architecture with Jumpbox by Renee Fung (click for docs)")](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/virtual-machines-windows/n-tier)

## IaaS resources docs

[Full IaaS walk through](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/infrastructure-example?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json)

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
- [Custom script extension](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/extensions-customscript)
- [Single template vs nested templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-template-best-practices#single-template-vs-nested-templates)

### Backup/restore

- [How to capture a VM image](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/capture-image)
- [Domain controller VMs cannot be captured (`sysprep` not supported)](https://msdn.microsoft.com/windows/hardware/commercialize/manufacture/desktop/sysprep-support-for-server-roles)

### Active Directory Domain Services

- [xActiveDirectory Desired State Configuration for Azure Automation](https://www.powershellgallery.com/packages/xActiveDirectory)
- [**Walk through Active Directory on Azure via DSC**](https://kvaes.wordpress.com/2017/04/29/azure-deploying-a-domain-controller-via-dsc-pull/)

### Desired State Configuration

- [List of learning resources](http://dille.name/blog/2014/12/10/useful-resources-to-teach-yourself-powershell-dsc/)

### PowerShell for Azure

- [Manage VMs with PowerShell](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-manage/)
- [Configure Remote Azure VM PowerShell Access with PowerShell](http://fabriccontroller.net/automatically-configuring-remote-powershell-for-windows-azure-virtual-machines-on-your-machine/)
- [Configure Remote Azure VM PowerShell Access](https://blogs.msdn.microsoft.com/mariok/2011/08/08/command-line-access-to-azure-vms-powershell-remoting/)
- [PowerShell script to Configure Secure Remote PowerShell Access to Windows Azure Virtual Machines](https://gallery.technet.microsoft.com/scriptcenter/Configures-Secure-Remote-b137f2fe)
- [Introduction to Remote PowerShell with Windows Azure](https://www.opsgility.com/blog/windows-azure-powershell-reference-guide/introduction-remote-powershell-with-windows-azure/)

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
