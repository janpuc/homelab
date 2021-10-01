resource "proxmox_vm_qemu" "homebridge" {
  name        = "homebridge"
  target_node = var.proxmox_node
  vmid        = 805

  clone   = "pihole-homebridge"
  os_type = "homebridge"
  boot    = "c"

  agent     = 1
  ipconfig0 = "ip=${var.homebridge_ip_address}/24,gw=${var.net_gateway}"
  sshkeys   = file(var.ssh_public_key)

  provisioner "remote-exec" {
    inline = ["echo provisioned"]

    connection {
      host  = var.homebridge_ip_address
      type  = "ssh"
      user  = var.homebridge_user
      agent = true
    }
  }
}
