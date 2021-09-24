resource "proxmox_vm_qemu" "fileserver" {
  name        = "fileserver"
  target_node = var.target_node
  vmid        = 801

  clone   = "debian-cloudinit"
  os_type = "cloudinit"
  boot    = "c"

  agent     = 1
  ipconfig0 = "ip=${var.fileserver_ip_address}/24,gw=${var.net_gateway}"
  sshkeys   = file(var.ssh_public_key)

  provisioner "remote-exec" {
    inline = ["echo provisioned"]

    connection {
      host = var.fileserver_ip_address
      type = "ssh"
      user = var.fileserver_user
      agent = true
    }
  }

  provisioner "local-exec" {
    command = ""
  }

  depends_on = [local_file.ansible_inventory]
}
