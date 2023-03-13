variable "name" {
  type        = string
  description = "The name of the VMSS to create"
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group should exist. Changing this forces a new resource to be created."
  default     = "eastus"
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator on each Virtual Machine Scale Set instance"
}

variable "admin_password" {
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine"
}

variable "computer_name_prefix" {
  type        = string
  description = "The prefix which should be used for the name of the Virtual Machines in this Scale Set."
  default     = null
}

variable "custom_data" {
  type        = string
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set"
  default     = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "Should Password Authentication be disabled on this Virtual Machine Scale Set?"
  default     = false
}

variable "do_not_run_extensions_on_overprovisioned_machines" {
  type        = bool
  description = "Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set? "
  default     = false
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine Scale Set should exist."
  default     = null
}

variable "rg_name" {
  type        = string
  description = "The name of the Resource Group in which the Linux Virtual Machine Scale Set should be exist"
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = false
}

variable "extension_operations_enabled" {
  type        = bool
  description = "Should extension operations be allowed on the Virtual Machine Scale Set?"
  default     = true
}

variable "extensions_time_budget" {
  type        = string
  description = "Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. "
  default     = "PT1H30M"
}

variable "overprovision_vms" {
  type        = string
  description = "Should Azure over-provision Virtual Machines in this Scale Set? "
  default     = false
}

variable "fault_domain_count" {
  type        = number
  description = "Specifies the number of fault domains that are used by this Linux Virtual Machine Scale Set"
  default     = null
}

variable "provision_vm_agent" {
  type        = bool
  description = "Should the Azure VM Agent be provisioned on each Virtual Machine in the Scale Set? "
  default     = true
}

variable "priority" {
  type        = string
  description = "The Priority of this Virtual Machine Scale Set. Possible values are Regular and Spot"
  default     = "Regular"
}

variable "secure_boot_enabled" {
  type        = bool
  description = "Specifies whether secure boot should be enabled on the virtual machine. "
  default     = null
}

variable "source_image_id" {
  type        = string
  description = "The ID of an Image which each Virtual Machine in this Scale Set should be based on"
  default     = null
}

variable "upgrade_mode" {
  type        = string
  description = "Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling"
  default     = "Manual"
}

variable "user_data" {
  type        = string
  description = "The Base64-Encoded User Data which should be used for this Virtual Machine Scale Set."
  default     = null
}

variable "balance_zones" {
  type        = bool
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones? "
  default     = true
}

variable "zones" {
  type        = list(string)
  description = "Specifies a list of Availability Zones in which this Linux Virtual Machine Scale Set should be located."
  default     = ["1", "2", "3"]
}

variable "auto_os_upgrade_policy" {
  type = object({
    enable_automatic_os_upgrade = bool
    disable_automatic_rollback  = bool
  })
  description = "Details about automatica OS Upgrade Policy"
  default     = null
}

variable "instance_repair_policy" {
  type = object({
    enabled      = bool
    grace_period = string
  })
  description = "Details about Instance Repair Policy"
  default     = null
}

variable "boot_diag_storage_account_uri" {
  type        = string
  description = "The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

variable "data_disks" {
  type = map(object({
    name                      = string
    caching                   = string
    disk_size_gb              = number
    create_option             = string
    lun                       = number
    storage_account_type      = string
    disk_encryption_set_id    = string
    write_accelerator_enabled = bool
  }))
  description = "Details about the data disk that are required to be attached "
  default     = null
}

variable "extensions" {
  type = map(object({
    name                       = string
    publisher                  = string
    type                       = string
    type_handler_version       = string
    auto_upgrade_minor_version = bool
    automatic_upgrade_enabled  = bool
    force_update_tag           = string
    protected_settings         = string
    provision_after_extensions = list(string)
    settings                   = string
    protected_settings_from_key_vault = object({
      secret_url      = string
      source_vault_id = string
    })
  }))
  description = "Details about the extensions that needs to be installed in VMSS"
  default     = null
}

variable "identity_info" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  description = "Details about the VMSS identity"
  default     = null
}

variable "network_interface_details" {
  type = map(object({
    name                          = string
    dns_servers                   = list(string)
    enable_accelerated_networking = bool
    enable_ip_forwarding          = bool
    network_security_group_id     = string
    primary                       = bool
    ip_configuration = map(object({
      name                                         = string
      application_gateway_backend_address_pool_ids = list(string)
      application_security_group_ids               = list(string)
      load_balancer_backend_address_pool_ids       = list(string)
      load_balancer_inbound_nat_rules_ids          = list(string)
      primary                                      = bool
      public_ip_address = object({
        name                    = string
        domain_name_label       = string
        idle_timeout_in_minutes = number
        public_ip_prefix_id     = string
        version                 = string
      })
    }))
  }))
  description = "Details about the VMSS network interface details."
}

variable "os_disk_info" {
  type = object({
    caching                   = string
    storage_account_type      = string
    disk_encryption_set_id    = string
    disk_size_gb              = number
    write_accelerator_enabled = bool
  })
  description = "Details about the VMSS OS disk"
}

variable "plan_info" {
  type = object({
    name      = string
    publisher = string
    product   = string
  })
  description = "Details about the VM plan info that will be created in VMSS"
  default     = null
}

variable "scale_in_policy" {
  type = object({
    rule                   = string
    force_deletion_enabled = bool
  })
  description = "Details about the VMSS scale in policy"
  default     = null
}

variable "rolling_upgrade_policy" {
  type = object({
    max_batch_instance_percent              = number
    max_unhealthy_instance_percent          = number
    max_unhealthy_upgraded_instance_percent = number
    pause_time_between_batches              = number
    cross_zone_upgrades_enabled             = bool
    prioritize_unhealthy_instances_enabled  = bool
  })
  description = "Details about the VMSS rolling upgrade policy"
  default     = null
}

variable "secrets_info" {
  type = map(object({
    key_vault_id = string
    certificate_urls = object({
      url = string
    })
  }))
  description = "Details about the secrets for VMSS that are available in Key Vault"
  default     = null
}

variable "sku_name" {
  type        = string
  description = "SKU Name for VMSS"
}

variable "termination_notification_info" {
  type = object({
    enabled = bool
    timeout = string
  })
  description = "Details about the termination notification in VMSS"
  default     = null
}

variable "source_image_ref" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Details about the image that will be used for this VMSS"
}

variable "key_vault_id" {
  type        = string
  description = "Details about the Key Vault to store the SSH keys incase password authentication is disabled for this key vault."
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource"
}
