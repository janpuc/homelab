resource "proxmox_vm_qemu" "pihole" {
  name        = "pihole"
  target_node = var.proxmox_node
  vmid        = 803

  clone   = "pihole-cloudinit"
  os_type = "cloudinit"
  boot    = "c"

  agent     = 1
  ipconfig0 = "ip=${var.pihole_ip_address}/24,gw=${var.net_gateway}"
  sshkeys   = file(var.ssh_public_key)

  provisioner "remote-exec" {
    inline = ["echo provisioned"]

    connection {
      host  = var.pihole_ip_address
      type  = "ssh"
      user  = var.pihole_user
      agent = true
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user ${var.pihole_user} --inventory '../../ansible/inventory' ../../ansible/playbooks/pihole/pihole.yml"
  }

  depends_on = [local_file.ansible_inventory]
}
