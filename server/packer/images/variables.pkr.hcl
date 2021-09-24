variable "proxmox_ip" {
  type        = string
  description = "The IP of the proxmox server."
}

variable "proxmox_port" {
  type        = string
  description = "The port used by the proxmox management interface."
  default     = "8006"
}

variable "proxmox_username" {
  type        = string
  description = "The user used to connect to proxmox."
}

variable "proxmox_password" {
  type        = string
  description = "The password for the proxmox user."
  sensitive   = true
}

variable "proxmox_node" {
  type        = string
  description = "The name of the proxmox node on which to create the template."
}

variable "proxmox_iso_storage_pool" {
  type        = string
  description = "The name of the proxmox storage pool to store ISOs in."
  default     = "local"
}
