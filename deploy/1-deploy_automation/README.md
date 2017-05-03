# 1-deploy_automation

Provisions an Automation Account (in a new Resource Group) which will be used to apply **Descired State Configuration**s to VMs.

## Deployment

execute PowerShell script: 1-deploy_automation\deploy.ps1

## Code explanation

based on [AD via DSC tutorial](https://kvaes.wordpress.com/2017/04/29/azure-deploying-a-domain-controller-via-dsc-pull/).


### 1-deploy_automation\deploy.ps1

1. **executes:** 1-deploy_automation\AutomationAccount\deploy.ps1
    1. **creates:** Resource Group
    1. **creates:** Automation Account
    1. **adds assets:** to Automation Account for later use
        1. **credential:** for AD admin
        1. **variable:** netbios domain name
        1. **variable:** domain name
1. **executes:** 1-deploy_automation\Scripts\deploy.ps1
    1. **executes:** 1-deploy_automation\Scripts\importAllConfigurations.ps1
        1. **loop executes:** 1-deploy_automation\Scripts\importConfiguration.ps1 for each configuration in 1-deploy_automation\Configurations\*
            1. *These are the "Desired State Configurations" that VMs can register to.  Once registered Automation Account ensures VM is compliant to the configuration.*
    1. **executes:** 1-deploy_automation\Scripts\importAllModules.ps1
        1. **loop executes:** 1-deploy_automation\Scripts\importConfir.ps1 for each module listed in each file in 1-deploy_automation\Modules\*
            1. *These (experimental) PowerShell modules are used by the Automation Account (ie DSC Pull Server for Azure) to apply the configurations that each VM is registered to.*
