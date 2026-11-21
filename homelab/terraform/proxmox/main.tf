terraform {
  required_version = "= 1.13.9"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "= 0.118.1"
    }
  }

  backend "local" {}

  encryption {
    key_provider "pbkdf2" "prod" {
      passphrase = var.state_passphrase
    }
    method "aes_gcm" "prod" {
      keys = key_provider.pbkdf2.prod
    }
    state {
      method   = method.aes_gcm.prod
      enforced = true
    }
    plan {
      method   = method.aes_gcm.prod
      enforced = true
    }
  }
}

variable "state_passphrase" {
  description = "Production OpenTofu encryption passphrase from 1Password."
  type        = string
  sensitive   = true
  ephemeral   = true
}

provider "proxmox" {
  endpoint = "https://192.168.4.200:8006/"
  insecure = false
}

locals {
  cluster = jsondecode(file("${path.module}/cluster.json"))
}

resource "proxmox_virtual_environment_vm" "talos" {
  for_each = local.cluster.nodes

  name      = each.key
  node_name = "biggie"
  vm_id     = each.value.id
  bios      = "ovmf"
  machine   = "q35"
  # The blank OS disk falls through to the ISO; subsequent boots prefer disk.
  boot_order = ["virtio0", "ide2"]
  on_boot    = true
  started    = true

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 4096
    floating  = 0
  }

  efi_disk {
    datastore_id      = "biggie-npool"
    type              = "4m"
    pre_enrolled_keys = false
  }

  cdrom {
    file_id   = local.cluster.iso
    interface = "ide2"
  }

  disk {
    datastore_id = "biggie-npool"
    interface    = "virtio0"
    serial       = "talos-os"
    size         = 32
  }

  disk {
    datastore_id = "biggie-npool"
    interface    = "virtio1"
    serial       = "talos-longhorn"
    size         = 48
  }

  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = each.value.mac
    firewall    = true
  }

  agent {
    enabled = true
    wait_for_ip {
      disabled = true
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
