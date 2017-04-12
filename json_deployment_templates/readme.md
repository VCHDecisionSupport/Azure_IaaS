# azure resources

## resource hierarchy

Use resource hierarchy to name by naming child resources as parent resources with an addition suffix/prefix.
I invented the concept of a "workload" to a describe group of vms in a single subnet that together.

- location
  - storage account
  - resource group
    - vnet
      - dsn server
      - domain
      - [workload]
        - subnet
          - nsg
          - [vm]
            - nic
              - public ip
            - os
            - size


## json parameters

- root_name: `vchds`
- location: "canadacentral"
- resource_group
  - resource_group_name: root_name ++ `-rg`
- storage_account
  - storage_account: storage_account_name ++ `sa`
- vnet
  - vnet_name: root_name ++ `-vnet`
  - dsn server
- domain
  - domain_name: root_name ++ `.ca`
- [workload]
  work_load_names:
  - `jb`
  - `addc`
  - `sp`
  - `sqldw`
  - `user`
  - `sandbox`
- subnet
  - subnet_name: work_load_name ++ `-subnet`
  - addressPrefix: "192.168.?.0/24"
  - nsg:
    - nsg_name: subnet_name ++ `-nsg`
    - nsg_rule_name: subnet_name ++ `-nsg-rdp-rule`
- vm
  - vm_name: work_load_name ++ `Vm` ++ ?
  - nic_name: vm_name
      - [vm]
        - nic
        - os
        - size
