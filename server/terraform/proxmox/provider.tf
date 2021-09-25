terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

variable "proxmox_port" {
  type        = number
  description = "Port used by Proxmox interface."
  default     = 8006
}

variable "proxmox_password" {
  type        = string
  description = "Password of the Terraform Proxmox user."
  sensitive   = true
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_ip}:${var.proxmox_port}/api2/json"
  pm_user         = var.proxmox_username
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
}
