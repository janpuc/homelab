resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl",
    {
      fileserver_ip   = var.fileserver_ip_address,
      fileserver_user = var.fileserver_user
    }
  )
  filename = "../../ansible/inventory/hosts.yaml"
}