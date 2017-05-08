# 3-deploy_addc

Provisions a VM then registers it to the already existing **Descired State Configuration** in the Automation Account.

## Deployment

execute PowerShell script: 3-deploy_addc\deploy.ps1

## Code explanation

based on [AD via DSC tutorial](https://kvaes.wordpress.com/2017/04/29/azure-deploying-a-domain-controller-via-dsc-pull/).

## Logic walk through

### 3-deploy_addc\deploy.ps1

1. **deploys:** 3-deploy_addc\azuredeploy.json
    1. **creates:** Managed data disk
    1. **creates:** Network interface card (nic)
    1. **creates:** virtual machine (vm)
        1. **attachs:** vm to nic
        1. **attachs (doesn't mount):** data disk to vm
    1. **registers:** vm to Desired State Configuration in Automation Account
        1. *the frequency of synchronization of vm to the pull server (ie. Automation Account) is specified in a **zipped** PowerShell file that downloaded from the url (github repo) specified*
    1. **deploys nested template:** 3-deploy_addc\update-nic.json
        1. updates the DNS server of the virtual network to the local ip of the DC VM
        1. *downloaded by Azure from given template uri (github repo)*