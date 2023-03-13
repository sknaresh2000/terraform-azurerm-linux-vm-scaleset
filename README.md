## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [tls_private_key.tls](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this Virtual Machine | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator on each Virtual Machine Scale Set instance | `string` | n/a | yes |
| <a name="input_auto_os_upgrade_policy"></a> [auto\_os\_upgrade\_policy](#input\_auto\_os\_upgrade\_policy) | Details about automatica OS Upgrade Policy | <pre>object({<br>    enable_automatic_os_upgrade = bool<br>    disable_automatic_rollback  = bool<br>  })</pre> | `null` | no |
| <a name="input_balance_zones"></a> [balance\_zones](#input\_balance\_zones) | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? | `bool` | `true` | no |
| <a name="input_boot_diag_storage_account_uri"></a> [boot\_diag\_storage\_account\_uri](#input\_boot\_diag\_storage\_account\_uri) | The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. | `string` | `null` | no |
| <a name="input_computer_name_prefix"></a> [computer\_name\_prefix](#input\_computer\_name\_prefix) | The prefix which should be used for the name of the Virtual Machines in this Scale Set. | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set | `string` | `null` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | Details about the data disk that are required to be attached | <pre>map(object({<br>    name                      = string<br>    caching                   = string<br>    disk_size_gb              = number<br>    create_option             = string<br>    lun                       = number<br>    storage_account_type      = string<br>    disk_encryption_set_id    = string<br>    write_accelerator_enabled = bool<br>  }))</pre> | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Should Password Authentication be disabled on this Virtual Machine Scale Set? | `bool` | `false` | no |
| <a name="input_do_not_run_extensions_on_overprovisioned_machines"></a> [do\_not\_run\_extensions\_on\_overprovisioned\_machines](#input\_do\_not\_run\_extensions\_on\_overprovisioned\_machines) | Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set? | `bool` | `false` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine Scale Set should exist. | `string` | `null` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `false` | no |
| <a name="input_extension_operations_enabled"></a> [extension\_operations\_enabled](#input\_extension\_operations\_enabled) | Should extension operations be allowed on the Virtual Machine Scale Set? | `bool` | `true` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | Details about the extensions that needs to be installed in VMSS | <pre>map(object({<br>    name                       = string<br>    publisher                  = string<br>    type                       = string<br>    type_handler_version       = string<br>    auto_upgrade_minor_version = bool<br>    automatic_upgrade_enabled  = bool<br>    force_update_tag           = string<br>    protected_settings         = string<br>    provision_after_extensions = list(string)<br>    settings                   = string<br>    protected_settings_from_key_vault = object({<br>      secret_url      = string<br>      source_vault_id = string<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_extensions_time_budget"></a> [extensions\_time\_budget](#input\_extensions\_time\_budget) | Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. | `string` | `"PT1H30M"` | no |
| <a name="input_fault_domain_count"></a> [fault\_domain\_count](#input\_fault\_domain\_count) | Specifies the number of fault domains that are used by this Linux Virtual Machine Scale Set | `number` | `null` | no |
| <a name="input_identity_info"></a> [identity\_info](#input\_identity\_info) | Details about the VMSS identity | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_instance_repair_policy"></a> [instance\_repair\_policy](#input\_instance\_repair\_policy) | Details about Instance Repair Policy | <pre>object({<br>    enabled      = bool<br>    grace_period = string<br>  })</pre> | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Details about the Key Vault to store the SSH keys incase password authentication is disabled for this key vault. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the resource group should exist. Changing this forces a new resource to be created. | `string` | `"eastus"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the VMSS to create | `string` | n/a | yes |
| <a name="input_network_interface_details"></a> [network\_interface\_details](#input\_network\_interface\_details) | Details about the VMSS network interface details. | <pre>map(object({<br>    name                          = string<br>    dns_servers                   = list(string)<br>    enable_accelerated_networking = bool<br>    enable_ip_forwarding          = bool<br>    network_security_group_id     = string<br>    primary                       = bool<br>    ip_configuration = map(object({<br>      name                                         = string<br>      application_gateway_backend_address_pool_ids = list(string)<br>      application_security_group_ids               = list(string)<br>      load_balancer_backend_address_pool_ids       = list(string)<br>      load_balancer_inbound_nat_rules_ids          = list(string)<br>      primary                                      = bool<br>      subnet_id                                    = string<br>      public_ip_address = object({<br>        name                    = string<br>        domain_name_label       = string<br>        idle_timeout_in_minutes = number<br>        public_ip_prefix_id     = string<br>        version                 = string<br>      })<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_os_disk_info"></a> [os\_disk\_info](#input\_os\_disk\_info) | Details about the VMSS OS disk | <pre>object({<br>    caching                   = string<br>    storage_account_type      = string<br>    disk_encryption_set_id    = string<br>    disk_size_gb              = number<br>    write_accelerator_enabled = bool<br>  })</pre> | n/a | yes |
| <a name="input_overprovision_vms"></a> [overprovision\_vms](#input\_overprovision\_vms) | Should Azure over-provision Virtual Machines in this Scale Set? | `string` | `false` | no |
| <a name="input_plan_info"></a> [plan\_info](#input\_plan\_info) | Details about the VM plan info that will be created in VMSS | <pre>object({<br>    name      = string<br>    publisher = string<br>    product   = string<br>  })</pre> | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The Priority of this Virtual Machine Scale Set. Possible values are Regular and Spot | `string` | `"Regular"` | no |
| <a name="input_provision_vm_agent"></a> [provision\_vm\_agent](#input\_provision\_vm\_agent) | Should the Azure VM Agent be provisioned on each Virtual Machine in the Scale Set? | `bool` | `true` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the Resource Group in which the Linux Virtual Machine Scale Set should be exist | `string` | n/a | yes |
| <a name="input_rolling_upgrade_policy"></a> [rolling\_upgrade\_policy](#input\_rolling\_upgrade\_policy) | Details about the VMSS rolling upgrade policy | <pre>object({<br>    max_batch_instance_percent              = number<br>    max_unhealthy_instance_percent          = number<br>    max_unhealthy_upgraded_instance_percent = number<br>    pause_time_between_batches              = number<br>    cross_zone_upgrades_enabled             = bool<br>    prioritize_unhealthy_instances_enabled  = bool<br>  })</pre> | `null` | no |
| <a name="input_scale_in_policy"></a> [scale\_in\_policy](#input\_scale\_in\_policy) | Details about the VMSS scale in policy | <pre>object({<br>    rule                   = string<br>    force_deletion_enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_secrets_info"></a> [secrets\_info](#input\_secrets\_info) | Details about the secrets for VMSS that are available in Key Vault | <pre>map(object({<br>    key_vault_id = string<br>    certificate_urls = object({<br>      url = string<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | Specifies whether secure boot should be enabled on the virtual machine. | `bool` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | SKU Name for VMSS | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | The ID of an Image which each Virtual Machine in this Scale Set should be based on | `string` | `null` | no |
| <a name="input_source_image_ref"></a> [source\_image\_ref](#input\_source\_image\_ref) | Details about the image that will be used for this VMSS | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(any)` | n/a | yes |
| <a name="input_termination_notification_info"></a> [termination\_notification\_info](#input\_termination\_notification\_info) | Details about the termination notification in VMSS | <pre>object({<br>    enabled = bool<br>    timeout = string<br>  })</pre> | `null` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling | `string` | `"Manual"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The Base64-Encoded User Data which should be used for this Virtual Machine Scale Set. | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Specifies a list of Availability Zones in which this Linux Virtual Machine Scale Set should be located. | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the Linux Virtual machine scale set |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Managed Identity used by this Virtual Machine scale set |
