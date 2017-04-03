# Lunch and Learn Outline

## Motivation and requirements
Dev/test environment for SharePoint

### Dev/test sharepoint environment. 
- Active directory with equivalent confirmation config as on premises 
- Sharepoint farm with topology and config as on premises 
- Mock data warehouse with same schema as DSDW and simulated data
- Turn key deployment from code
- Schedule automatic deallocation of vms

### Cloud service model 
- SaaS vs paas vs iaas 
- Aws vs azure

### Azure deployment. 
- Classic vs ARM 
- PowerShell vs json vs cli

### Active directory and networking protocols
- Directory service in general 
- Windows domain services 
- DNS 
- DCHP

### Exploring vch/imts infrastructure

### Network infrastructure 
- Vnet 
- Subnet 
- Nsg 
- Nic
- Pip
- Vm
- Size and os
- Jumpbox

### Server software
- Deployment automation with Chef

#### Data warehouse
- Chef install 
- On premises schema export and data profiling 
- Generation of data simulation

#### SharePoint 
- Chef install 
- On premises config export