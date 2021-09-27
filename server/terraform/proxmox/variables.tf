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

variable "pihole_ip_address" {
  type        = string
  description = "IP address of pi-hole."
}

variable "pihole_user" {
  type        = string
  description = "User account of the pi-hole."
  default     = "debian"
}


variable "master_node_ip_address" {
  type        = string
  description = "IP address of k3os node."
}

variable "k3os_user" {
  type        = string
  description = "User for the k3os machine."
  default     = "rancher"
}
