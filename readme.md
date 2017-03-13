# VCH Decision Support

# Remoting into VMs

1. Remote into Jumpbox VM from local PC
 - use FQDN (since underlying IP may change if/when VMs are redeployed)
 - make sure they've been turned on
2. Remote from Jumpbox VM to any other VM
 - use host name (ie vm name)

# Azure Deployment Decisions

- There are three categories of "cloud" deployments:
	- software as a service (SaaS) eg. Office365
	- platform as a service (SaaS) eg. SQL Server (IMTS-DS model, no control/access to underlying network/VM/OS)
	- infrastructure as a service (IaaS) eg. Virtual Network/Virtual Machines (HSBC-IMTS model, no control/access to underlying physical hardware)

- Allow access to Azure resouces through a _single permanent static IP address_ a [**Jumpbox** style architecture that followed](https://azure.microsoft.com/en-us/documentation/articles/guidance-compute-3-tier-vm/).  
	* IMTS only needs to open **access from on-premises vch.ca domain to single Azure NIC IP address**
	* Management of VMs is done is Remote Desktop to the Jumpbox VM (whose IP address IMTS has granted vch access to).  From Jumpbox users remote into other VMs in the Virtual Network

[![](https://raw.githubusercontent.com/VCHDecisionSupport/Azure_IaaS/master/misc/network_diagram.png "2 tier Architecture with Jumpbox by Renee Fung (click to see tutorial)")](https://azure.microsoft.com/en-us/documentation/articles/guidance-compute-3-tier-vm/)

## Active Directory Domain Controller
_active directory_ stores sensitive login and 

[Azure provided name resolution](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-name-resolution-for-vms-and-role-instances/) does not meet our requirement to replicate/debug end-user experience of SharePoint (and Bonzai/AgilePoint)<sup id="a3">[3](#f3)</sup>.
Custom Domain Controller will allow us to:

- replicate the permissions of our real-world end-users with mock AD end-user accounts/signins
- eventually (not currently planned/understood) sync on-premises AD with Azure VM ADDC **(there are important security and privacy implications with connecting/syncing Azure resources with VCH on premises resources)**

**Dcpromo.exe** [depricated in favour of PS based deployment](https://technet.microsoft.com/windows-server-docs/identity/ad-ds/deploy/install-a-new-windows-server-2012-active-directory-forest--level-200-)

## Other Deployment Details

- Azure's _Resource Manager_ **Deployment Model** was used rather than the legacy _Classic_ because new Azure features will only be available via _Resource Manager_ and VMs and other [resources created with one model can't necessarily interoperate with resources created using a different deployment.](https://azure.microsoft.com/en-us/documentation/articles/azure-classic-rm/#why-does-this-matter)<sup id="a00">[00](#f00)</sup>
- **Virtual Networks** must be deployed before the VMs because VMs can only be bound to vnet when they are deployed.<sup id="a2">[2](#f2)</sup>
- IPs in Virtual Network are grouped into **subnets** according to their workload and access they resource require
	* where ever possible **network security groups** are applied to subnets rather than single **network interface cards**
	* this simplifies the design of **access control lists** since they are applied multiple VM **network interface cards** at once <sup id="a4">[4](#f4)</sup>
- Best practices were followed to establish [**naming conventions**](https://azure.microsoft.com/en-us/documentation/articles/guidance-naming-conventions/) for all resources in the VNet.  If Azure is adopted as permanent dev/test enviroment the subscription should adhere to these recommendations.
	* [**tags**](https://azure.microsoft.com/en-us/documentation/articles/resource-group-using-tags/#powershell) categorize disparate resources accross different Resource Groups so that they can managed (eg. de/re-allocated) together.  Tags also provide clarity in bills by identitfying high-cost tags.
	
## Software Installation (SQL and SharePoint); Licencing and MSDN Questions

- Azure provides VM images with various version combinations<sup id="a5">[5](#f5)</sup> of Windows Server and SQL Server preinstalled that could **simplify software installation** and **clarify billing** ([see here for information about **Bring Your Own Licence (BYOL)**](https://azure.microsoft.com/en-gb/documentation/articles/virtual-machines-windows-sql-server-iaas-overview/#option-2-deploy-a-sql-vm-byol):
	* SQL2008R2SP3-WS2008R2SP1
	* SQL2008R2SP3-WS2012
	* SQL2012SP3-WS2012R2
	* SQL2012SP3-WS2012R2-BYOL
	* SQL2014SP1-WS2012R2
	* SQL2014SP1-WS2012R2-BYOL
	* SQL2016-WS2012R2
	* SQL2016-WS2012R2-BYOL
	* SQL2016RC3-WS2012R2
- These images include the installation media on the `C:/` drive of the VM so configuration adjustments could be made as needed.
	* It's not clear whether or not VM images would work for our SharePoint needs or whether BYOL is available

# Tear Down Sequence of Azure IaaS Deployment

1. Remove VMs
2. Remove NICs
3. Remove PIPs
4. Remove Subnets
5. Remove NSGs
6. Remove Virtual Networks
7. Remove Storage Accounts
8. Remove Resource Groups

## Virtual Network:
**IP Range:** 192.168.0.0/16

**Domain:** vch.ca



<b id="f1">1</b> [See here.]() [↩](#a1)

<b id="f2">2</b> [See here Microsoft documentation](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-overview/#strongnotestrong-1) [↩](#a2)

<b id="f3">3</b> When/if named resolved communication with vnet or to on-premises then a dedicated Domain Controller server will be added to our vnet but communication within vnet would still be handled by Azure.  Communication between Vms and instance roles within a vnet would reference different names than those used by communication from outside vnet?  Those the same Azure VM would have one name to other Azure VMs in the same vnet and another name to on premises connections.  [↩](#a3)

<b id="f4">4</b> [See here for VNet and subnet design.](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-nsg/#subnets)  [↩](#a4)

<b id="f00">00</b> [See here for benefits of Resource Manager.](https://azure.microsoft.com/en-us/documentation/articles/resource-group-overview/#the-benefits-of-using-resource-manager)  [↩](#a00)


# Other useful documentation:

[Azure VM sizing](https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/)

[Create DNS Zone](https://azure.microsoft.com/en-us/documentation/articles/dns-getstarted-create-dnszone/)


[Install a new Active Directory forest on an Azure virtual network](https://azure.microsoft.com/en-us/documentation/articles/active-directory-new-forest-virtual-machine/)

## PowerShell

[Manage VMs with PowerShell](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-manage/)

[Configure Remote Azure VM PowerShell Access with PowerShell](http://fabriccontroller.net/automatically-configuring-remote-powershell-for-windows-azure-virtual-machines-on-your-machine/)

[Configure Remote Azure VM PowerShell Access](https://blogs.msdn.microsoft.com/mariok/2011/08/08/command-line-access-to-azure-vms-powershell-remoting/)

[PowerShell script to Configure Secure Remote PowerShell Access to Windows Azure Virtual Machines](https://gallery.technet.microsoft.com/scriptcenter/Configures-Secure-Remote-b137f2fe)

[Introduction to Remote PowerShell with Windows Azure](https://www.opsgility.com/blog/windows-azure-powershell-reference-guide/introduction-remote-powershell-with-windows-azure/)