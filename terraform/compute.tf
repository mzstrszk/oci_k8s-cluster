resource "oci_core_instance" "com_k8s-master" {
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment_id
    shape = var.shape
    display_name = "k8s-master"

    shape_config {
        ocpus = 2
        memory_in_gbs = 12
    }

    source_details {
        source_type = "image"
        source_id = var.image_id
    }

    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.priv-sub_k8s.id
        nsg_ids = [oci_core_network_security_group.nsg_k8s-master.id]
    }
    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    } 
    preserve_boot_volume = false
}

resource "oci_core_instance" "com_k8s-worker01" {
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment_id
    shape = var.shape
    display_name = "k8s-worker01"

    shape_config {
        ocpus = 1
        memory_in_gbs = 6
    }

    source_details {
        source_type = "image"
        source_id = var.image_id
    }

    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.priv-sub_k8s.id
        nsg_ids = [oci_core_network_security_group.nsg_k8s-worker.id]
    }
    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    } 
    preserve_boot_volume = false
}

resource "oci_core_instance" "com_k8s-worker02" {
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment_id
    shape = var.shape
    display_name = "k8s-worker02"

    shape_config {
        ocpus = 1
        memory_in_gbs = 6
    }

    source_details {
        source_type = "image"
        source_id = var.image_id
    }

    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.priv-sub_k8s.id
        nsg_ids = [oci_core_network_security_group.nsg_k8s-worker.id]
    }
    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    } 
    preserve_boot_volume = false
}