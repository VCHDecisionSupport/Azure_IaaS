# [Click here for Agile Story Board for Azure](https://waffle.io/VCHDecisionSupport/SP-on-Azure)

# Deployed VM FQDN Names

- jumpboxvm1.canadacentral.cloudapp.azure.com
- dwvm1.canadacentral.cloudapp.azure.com
- sharepointvm1.canadacentral.cloudapp.azure.com
- sharepointvm2.canadacentral.cloudapp.azure.com
- sharepointvm3.canadacentral.cloudapp.azure.com

# Remoting into VMs

1. Remote into Jumpbox VM from local PC
 - use FQDN (since underlying IP may change if/when VMs are redeployed)
 - make sure they've been turned on
2. Remote from Jumpbox VM to any other VM
 - use host name (ie vm name)

# Azure Deployment Decisions

- Allow access to Azure resouces through a _single permanent static IP address_ a [**Jumpbox** style architecture that followed](https://azure.microsoft.com/en-us/documentation/articles/guidance-compute-3-tier-vm/).  
	* IMTS only needs to open **access from on-premises vch.ca domain to single IP address**
	* Management of VMs is done is Remote Desktop to the Jumpbox VM (whose IP address IMTS has granted vch access to).  From Jumpbox users remote into other VMs in the Virtual Network

[![](https://acom.azurecomcdn.net/80C57D/cdn/mediahandler/docarticles/dpsmedia-prod/azure.microsoft.com/en-us/documentation/articles/guidance-compute-3-tier-vm/20160811062725/compute-n-tier.png "3-Tier Architecture with Jumpbox (click to see tutorial)")](https://azure.microsoft.com/en-us/documentation/articles/guidance-compute-3-tier-vm/)

- Domain Controller may not nessisary since all VMs and role instances will be deployed to same Virtual Network and they don't need to communicate to any on premises computers [Azure provided name resolution](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-name-resolution-for-vms-and-role-instances/) will work.<sup id="a3">[3](#f3)</sup>
	* this doesn't solve need to have mock users accounts are manage permissions: 
		- **how does a Domain Controller interact with Network Security Groups?**

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




this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information

this is brilliant information



<b id="f1">1</b> [See here.]() [↩](#a1)

<b id="f2">2</b> [See here Microsoft documentation](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-overview/#strongnotestrong-1) [↩](#a2)

<b id="f3">3</b> When/if named resolved communication with vnet or to on-premises then a dedicated Domain Controller server will be added to our vnet but communication within vnet would still be handled by Azure.  Communication between Vms and instance roles within a vnet would reference different names than those used by communication from outside vnet?  Those the same Azure VM would have one name to other Azure VMs in the same vnet and another name to on premises connections.  [↩](#a3)

<b id="f4">4</b> [See here for VNet and subnet design.](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-nsg/#subnets)  [↩](#a4)

<b id="f00">00</b> [See here for benefits of Resource Manager.](https://azure.microsoft.com/en-us/documentation/articles/resource-group-overview/#the-benefits-of-using-resource-manager)  [↩](#a00)


# Other useful documentation:

[Azure VM sizing](https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/)

[Create DNS Zone](https://azure.microsoft.com/en-us/documentation/articles/dns-getstarted-create-dnszone/)

[Manage VMs with PowerShell](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-ps-manage/)

[Install a new Active Directory forest on an Azure virtual network](https://azure.microsoft.com/en-us/documentation/articles/active-directory-new-forest-virtual-machine/)

