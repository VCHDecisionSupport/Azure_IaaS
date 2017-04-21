# Azure json template IaaS deployment

## How to:

### Browse existing resources

Manage Azure visually from browser with point & click.  Go to: [www.azureportal.com](www.azureportal.com).

### Deploy and configure from code

Turn key deployment: execute `json_deployment_templates/deploy.ps1`

## Infrastructure Resources

`deploy.ps1` creates:

- resource group
- storage account
- virtual network
- subnets
- network security groups
- network interface cards
- public static ips
- private static ips
- virtual machines

#### Post-Deployment Server Configuration

- Active Directory
  - install active directory and DNS server roles
  - create new domain forest with VM as domain controller
  - join other vms to domain

## __How to:__ Restore from VMs from images

todo

## __How to:__ Configure deployment

## Design Rationale
