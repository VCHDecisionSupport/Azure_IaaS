# Epic

As a bad ass I want Azure resources to accommadate:

- Share Point deployment

# Azure Deployment Decisions

- Azure's _Resource Manager_ **Deployment Model** was used rather than the legacy _Classic_ because new Azure features will only be available via _Resource Manager_ and VMs and other [resources created with one model can't necessarily interoperate with resources created using a different deployment.](https://azure.microsoft.com/en-us/documentation/articles/azure-classic-rm/#why-does-this-matter)<sup id="a00">[00](#f00)</sup>

- Domain Controller not nessisary since all VMs and role instances will be deployed to same Virtual Network and they don't need to communicate to any on premises computers [Azure provided name resolution](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-name-resolution-for-vms-and-role-instances/) will work.<sup id="a3">[3](#f3)</sup>

- **Virtual Networks** must be deployed before the VMs because VMs can only be bound to vnet when they are deployed.<sup id="a2">[2](#f2)</sup>

- IPs in Virtual Network are grouped into **subnets** according to their workload and access they resource require
	* where ever possible **network security groups** are applied to subnets rather than single **network interface cards**
	* this simplifies the design of **access control lists** since they are applied multiple VM **network interface cards** at once <sup id="a4">[4](#f4)</sup>

- Best practices were followed to establish [**naming conventions**](https://azure.microsoft.com/en-us/documentation/articles/guidance-naming-conventions/) for all resources in the VNet.  If Azure is adopted as permanent dev/test enviroment the subscription should adhere to these recommendations.
	* [**tags**](https://azure.microsoft.com/en-us/documentation/articles/resource-group-using-tags/#powershell) categorize disparate resources accross different Resource Groups so that they can managed (eg. de/re-allocated) together.  Tags also provide clarity in bills by identitfying high-cost tags.
	



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

<b id="f2">2</b> [See here.](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-overview/#strongnotestrong-1) [↩](#a2)

<b id="f3">3</b> When/if named resolved communication with vnet or to on-premises then a dedicated Domain Controller server will be added to our vnet but communication within vnet would still be handled by Azure.  Communication between Vms and instance roles within a vnet would reference different names than those used by communication from outside vnet?  Those the same Azure VM would have one name to other Azure VMs in the same vnet and another name to on premises connections.  [↩](#a3)

<b id="f4">4</b> [See here.](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-nsg/#subnets)  [↩](#a4)

<b id="f00">00</b> [See here for benefits of Resource Manager.](https://azure.microsoft.com/en-us/documentation/articles/resource-group-overview/#the-benefits-of-using-resource-manager)  [↩](#a00)


# Other useful documentation:

[Azure VM sizing](https://azure.microsoft.com/en-us/documentation/articles/cloud-services-sizes-specs/)

[Create DNS Zone](https://azure.microsoft.com/en-us/documentation/articles/dns-getstarted-create-dnszone/)

[Install a new Active Directory forest on an Azure virtual network](https://azure.microsoft.com/en-us/documentation/articles/active-directory-new-forest-virtual-machine/)

