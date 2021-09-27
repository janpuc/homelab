resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl",
    {
      fileserver_ip   = var.fileserver_ip_address,
      fileserver_user = var.fileserver_user,
      pihole_ip       = var.pihole_ip_address,
      pihole_user     = var.pihole_user,
      master_node_ip  = var.master_node_ip_address,
      k3os_user       = var.k3os_user
    }
  )
  filename = "../../ansible/inventory/hosts.yml"
}
