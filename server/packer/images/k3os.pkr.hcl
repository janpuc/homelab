variable "nameserver" {
  type = string
  description = "IP of the nameserver."
}

variable "master_node_ip" {
  type = string
  description = "IP address used by the master k3s node."
}

variable "github_username" {
  type = string
  description = "GitHub username from which to add an autorized SSH key."
}

source "proxmox" "k3os_cloudinit" {
  proxmox_url = "https://${var.proxmox_ip}:${var.proxmox_port}/api2/json"
  username = var.proxmox_username
  password = var.proxmox_password
  node = var.proxmox_node
  iso_url = "https://github.com/rancher/k3os/releases/download/v0.20.11-k3s1r1/k3os-amd64.iso"
  iso_storage_pool = var.proxmox_iso_storage_pool
  iso_checksum = "sha256:b7b3fff6a4e1ba9602480b67870d4345ae84410b49421691c8596310bd856c85"
  insecure_skip_tls_verify = true

  cloud_init = true
  cloud_init_storage_pool = "local-lvm"
  cores = 2
  disks {
    disk_size         = "50G"
    format            = "qcow2"
    storage_pool      = "local-lvm"
    storage_pool_type = "lvm-thin"
  }
  memory = 6144
  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }
  onboot           = true
  qemu_agent       = true
  scsi_controller  = "virtio-scsi-pci"
  ssh_username     = "rancher"
  ssh_agent_auth   = true
  ssh_wait_timeout = "10000s"
  template_name    = "k3os-cloudinit"
  unmount_iso      = true
  vm_name          = "provisioning-k3os-template"
  vm_id            = 9001

  boot_command = [
    "<wait><tab>",
    "<down>",
    "<wait>",
    "e",
    "<down>",
    "<down>",
    "<down>",
    "<down>",
    "<down>",
    "<down>",
    "<end>",
    "<spacebar>",
    "k3os.mode=install",
    "<spacebar>",
    "k3os.install.config_url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.yaml",
    "<spacebar>",
    "k3os.install.silent=false",
    "<spacebar>",
    "k3os.install.device=/dev/sda",
    "<spacebar>",
    "k3os.install.debug=true",
    "<wait>",
    "<F10>",
    "<wait30s>",
    "y",
    "<enter>"
  ]
  boot_wait = "10s"
  http_content = {
    "/config.yaml" = templatefile("${path.cwd}/server/packer/templates/k3os-config.pkrtpl.hcl", { hostname = "k3os-master", node_ip = var.master_node_ip, nameserver = var.nameserver, github_username = var.github_username })
  }
}

build {
  sources = ["source.proxmox.k3os_cloudinit"]
}