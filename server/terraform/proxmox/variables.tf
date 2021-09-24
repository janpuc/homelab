variable "proxmox_ip" {
  type        = string
  description = "The IP of Proxmox server."
}

variable "proxmox_username" {
  type        = string
  description = "Proxmox terraform user."
}

variable "proxmox_node" {
  type        = string
  description = "Name of Proxmox node."
}

variable "ssh_public_key" {
  type        = string
  description = "Path of SSH public key."
  default     = "~/.ssh/id_rsa.pub"
}

variable "net_gateway" {
  type        = string
  description = "IP address of LAN gateway."
}

variable "fileserver_ip_address" {
  type        = string
  description = "IP address of fileserver."
}

variable "fileserver_user" {
  type        = string
  description = "User account of the fileserver."
  default     = "debian"
}
