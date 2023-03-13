resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                                              = var.name
  location                                          = var.location
  resource_group_name                               = var.rg_name
  admin_username                                    = var.admin_username
  admin_password                                    = var.disable_password_authentication ? null : var.admin_password
  computer_name_prefix                              = var.computer_name_prefix
  custom_data                                       = var.custom_data
  disable_password_authentication                   = var.disable_password_authentication
  do_not_run_extensions_on_overprovisioned_machines = var.do_not_run_extensions_on_overprovisioned_machines
  edge_zone                                         = var.edge_zone
  encryption_at_host_enabled                        = var.encryption_at_host_enabled
  extension_operations_enabled                      = var.extension_operations_enabled
  extensions_time_budget                            = var.extensions_time_budget
  overprovision                                     = var.overprovision_vms
  platform_fault_domain_count                       = var.fault_domain_count
  provision_vm_agent                                = var.provision_vm_agent
  priority                                          = var.priority
  secure_boot_enabled                               = var.secure_boot_enabled
  sku                                               = var.sku_name
  source_image_id                                   = var.source_image_ref == null ? var.source_image_id : null
  upgrade_mode                                      = var.upgrade_mode
  user_data                                         = var.user_data
  zone_balance                                      = var.balance_zones
  zones                                             = var.zones
  tags                                              = var.tags

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = tls_private_key.tls[0].public_key_openssh
    }
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.auto_os_upgrade_policy != null ? [1] : []
    content {
      enable_automatic_os_upgrade = automatic_os_upgrade_policy.value.enable_automatic_os_upgrade
      disable_automatic_rollback  = automatic_os_upgrade_policy.value.disable_automatic_rollback
    }
  }

  dynamic "automatic_instance_repair" {
    for_each = var.instance_repair_policy != null ? [1] : []
    content {
      enabled      = automatic_instance_repair.value.enabled
      grace_period = automatic_instance_repair.value.grace_period
    }
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diag_storage_account_uri
  }

  dynamic "data_disk" {
    for_each = var.data_disks != null ? var.data_disks : {}
    content {
      name                      = data_disk.value.name
      caching                   = data_disk.value.caching
      disk_size_gb              = data_disk.value.disk_size_gb
      create_option             = data_disk.value.create_option
      lun                       = data_disk.value.lun
      storage_account_type      = data_disk.value.storage_account_type
      disk_encryption_set_id    = data_disk.value.disk_encryption_set_id
      write_accelerator_enabled = data_disk.value.write_accelerator_enabled
    }
  }

  dynamic "extension" {
    for_each = var.extensions
    content {
      name                       = extension.value.name
      publisher                  = extension.value.publisher
      type                       = extension.value.type
      type_handler_version       = extension.value.type_handler_version
      auto_upgrade_minor_version = extension.value.auto_upgrade_minor_version
      automatic_upgrade_enabled  = extension.value.automatic_upgrade_enabled
      force_update_tag           = extension.value.force_update_tag
      protected_settings         = extension.value.protected_settings
      provision_after_extensions = extension.value.provision_after_extensions
      settings                   = extension.value.settings
      dynamic "protected_settings_from_key_vault" {
        for_each = extension.value.protected_settings_from_key_vault != null ? [1] : [0]
        content {
          secret_url      = protected_settings_from_key_vault.value.secret_url
          source_vault_id = protected_settings_from_key_vault.value.source_vault_id
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity_info != null ? [1] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface_details
    content {
      name                          = network_interface.value.name
      dns_servers                   = network_interface.value.dns_servers
      enable_accelerated_networking = network_interface.value.enabled_accelerated_networking
      enable_ip_forwarding          = network_interface.value.enable_ip_forwarding
      network_security_group_id     = network_interface.value.network_security_group_id
      primary                       = network_interface.value.primary
      dynamic "ip_configuration" {
        for_each = network_interface.value.ip_config_details != null ? network_interface.value.ip_config_details : []
        content {
          name                                         = ip_configuration.value.name
          application_gateway_backend_address_pool_ids = ip_configuration.value.application_gateway_backend_address_pool_ids
          application_security_group_ids               = ip_configuration.value.application_security_group_ids
          load_balancer_backend_address_pool_ids       = ip_configuration.value.load_balancer_backend_address_pool_ids
          load_balancer_inbound_nat_rules_ids          = ip_configuration.value.load_balancer_inbound_nat_rules_ids
          primary                                      = ip_configuration.value.primary
          dynamic "public_ip_address" {
            for_each = ip_configuration.value.public_ip_address != null ? [1] : []
            content {
              name                    = public_ip_address.value.name
              domain_name_label       = public_ip_address.value.domain_name_label
              idle_timeout_in_minutes = public_ip_address.value.idle_timeout_in_minutes
              public_ip_prefix_id     = public_ip_address.value.public_ip_prefix_id
              version                 = public_ip_address.value.version
            }
          }
        }
      }
    }
  }

  os_disk {
    caching                   = var.os_disk_info.caching
    storage_account_type      = var.os_disk_info.storage_account_type
    disk_encryption_set_id    = var.os_disk_info.disk_encryption_set_id
    disk_size_gb              = var.os_disk_info.disk_size_gb
    write_accelerator_enabled = var.os_disk_info.write_accelerator_enabled
  }

  plan {
    name      = var.plan_info.name
    publisher = var.plan_info.publisher
    product   = var.plan_info.product
  }

  dynamic "scale_in" {
    for_each = var.scale_in_policy != null ? [1] : []
    content {
      rule                   = scale_in.value.rule
      force_deletion_enabled = scale_in.value.force_deletion_enabled
    }
  }

  dynamic "rolling_upgrade_policy" {
    for_each = var.rolling_upgrade_policy != null ? [1] : []
    content {
      max_batch_instance_percent              = rolling_upgrade_policy.value.max_batch_instance_percent
      max_unhealthy_instance_percent          = rolling_upgrade_policy.value.max_unhealthy_instance_percent
      max_unhealthy_upgraded_instance_percent = rolling_upgrade_policy.value.max_unhealthy_upgraded_instance_percent
      pause_time_between_batches              = rolling_upgrade_policy.value.pause_time_between_batches
      cross_zone_upgrades_enabled             = rolling_upgrade_policy.value.cross_zone_upgrades_enabled
      prioritize_unhealthy_instances_enabled  = rolling_upgrade_policy.value.prioritize_unhealthy_instances_enabled
    }
  }

  dynamic "secret" {
    for_each = var.secrets_info
    content {
      key_vault_id = secret.value.key_vault_id
      dynamic "certificate" {
        for_each = secret.value.certificate_urls
        content {
          url = certificate.value.url
        }
      }
    }
  }

  dynamic "termination_notification" {
    for_each = var.termination_notification_info != null ? [1] : []
    content {
      enabled = termination_notification.value.enabled
      timeout = termination_notification.value.timeout
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_ref != null ? [1] : []
    content {
      publisher = var.source_image_ref.publisher
      offer     = var.source_image_ref.offer
      sku       = var.source_image_ref.sku
      version   = var.source_image_ref.version
    }
  }
}

resource "tls_private_key" "tls" {
  count     = var.disable_password_authentication ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "secret" {
  count        = var.disable_password_authentication ? 1 : 0
  name         = "${var.name}-key"
  value        = tls_private_key.tls[0].private_key_openssh
  key_vault_id = var.key_vault_id
}