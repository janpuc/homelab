variable "key_fp" {
  type        = string
  description = "Fingerprint of the GPG key used by SOPS."
  default     = "F87EE91C12866F36C1CC99E88606529B1E68B608"
}

resource "proxmox_vm_qemu" "k3os_master" {
  name        = "k3os-master"
  target_node = var.proxmox_node
  vmid        = 802

  clone   = "k3os-cloudinit"
  os_type = "cloudinit"
  boot    = "c"

  agent  = 1
  cores  = 2
  memory = 6144

  provisioner "remote-exec" {
    inline = [
      "systemctl reboot",
      "echo provisioned",
    ]

    connection {
      host        = var.master_node_ip_address
      type        = "ssh"
      user        = var.k3os_user
      agent       = true
      script_path = "~/is-provisioned.sh"
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user ${var.k3os_user} --inventory '../../ansible/inventory' --extra-vars \"key_fp=${var.key_fp} repo_dir=${path.cwd}\" ../../ansible/playbooks/kubernetes/kubernetes.yml"
  }

  depends_on = [local_file.ansible_inventory]
}
