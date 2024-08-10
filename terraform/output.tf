# Outputs for compute instance
# availability domain
output "name-of-first-availability-domain" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

# k8s-master
output "k8s-master_public-ip" {
  value = oci_core_instance.com_k8s-master.public_ip
}

output "k8s-master_private-ip" {
  value = oci_core_instance.com_k8s-master.private_ip
}

output "k8s-master_instance-name" {
  value = oci_core_instance.com_k8s-master.display_name
}

output "k8s-master_instance-OCPUs" {
  value = oci_core_instance.com_k8s-master.shape_config[0].ocpus
}

output "k8s-master_instance-memory-in-GBs" {
  value = oci_core_instance.com_k8s-master.shape_config[0].memory_in_gbs
}

output "k8s-master_time-created" {
  value = oci_core_instance.com_k8s-master.time_created
}

# k8s-worker01
output "k8s-worker01_public-ip" {
  value = oci_core_instance.com_k8s-worker01.public_ip
}

output "k8s-worker01_private-ip" {
  value = oci_core_instance.com_k8s-worker01.private_ip
}

output "k8s-worker01_instance-name" {
  value = oci_core_instance.com_k8s-worker01.display_name
}

output "k8s-worker01_instance-OCPUs" {
  value = oci_core_instance.com_k8s-worker01.shape_config[0].ocpus
}

output "k8s-worker01_instance-memory-in-GBs" {
  value = oci_core_instance.com_k8s-worker01.shape_config[0].memory_in_gbs
}

output "k8s-worker01_time-created" {
  value = oci_core_instance.com_k8s-worker01.time_created
}

# k8s-worker02
output "k8s-worker02_public-ip" {
  value = oci_core_instance.com_k8s-worker02.public_ip
}

output "k8s-worker02_private-ip" {
  value = oci_core_instance.com_k8s-worker02.private_ip
}

output "k8s-worker02_instance-name" {
  value = oci_core_instance.com_k8s-worker02.display_name
}

output "k8s-worker02_instance-OCPUs" {
  value = oci_core_instance.com_k8s-worker02.shape_config[0].ocpus
}

output "k8s-worker02_instance-memory-in-GBs" {
  value = oci_core_instance.com_k8s-worker02.shape_config[0].memory_in_gbs
}

output "k8s-worker02_time-created" {
  value = oci_core_instance.com_k8s-worker02.time_created
}

# ansible inventory
resource "local_file" "inventory" {
  depends_on = [
    oci_core_instance.com_k8s-master,
    oci_core_instance.com_k8s-worker01,
    oci_core_instance.com_k8s-worker02
  ]
  content = templatefile("./ansible_inventory.tftpl",
    {
      k8s-master = oci_core_instance.com_k8s-master
      k8s-worker01 = oci_core_instance.com_k8s-worker01
      k8s-worker02 = oci_core_instance.com_k8s-worker02
      ansible_user = var.ansible_user
      ssh_port = var.ssh_port
      ssh_private_key_path = var.ssh_private_key_path
    }
  )
  filename = "../ansible/inventory.ini"
}