terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.7.4"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.10:8006/api2/json"
  pm_user         = "tmp@pve"
  pm_password     = "tmp"
  pm_tls_insecure = true
}
