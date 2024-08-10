# k8sマスターノード - EGRESS
resource "oci_core_network_security_group" "nsg_k8s-master" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn_k8s.id
    display_name = "k8s-master"
}

resource "oci_core_network_security_group_security_rule" "nsg_k8s-master_egress" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-master.id
    direction = "EGRESS"
    protocol = "all"
    description = "Allow all Egress traffic"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

# k8sワーカーノード - EGRESS
resource "oci_core_network_security_group" "nsg_k8s-worker" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn_k8s.id
    display_name = "k8s-worker"
}

resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_egress" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-worker.id
    direction = "EGRESS"
    protocol = "all"
    description = "Allow all Egress traffic"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}


# k8sマスター -> ワーカー
resource "oci_core_network_security_group_security_rule" "nsg_k8s-master_worker_ingress_10250" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-worker.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "k8sマスター to ワーカーノード用"
    source_type = "NETWORK_SECURITY_GROUP"
    source = oci_core_network_security_group.nsg_k8s-master.id
    tcp_options {
        destination_port_range {
            min = 10250
            max = 10250
        }
    }
}
resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_open_ingress_30000-32767" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-worker.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "ワーカーノード公開用"
    source_type = "CIDR_BLOCK"
    source = "0.0.0.0/0"
    tcp_options {
        destination_port_range {
            min = 30000
            max = 32767
        }
    }
}

# k8sワーカー -> マスター
resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_master_ingress_6443" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-master.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "k8sワーカー to マスターノード用"
    source_type = "NETWORK_SECURITY_GROUP"
    source = oci_core_network_security_group.nsg_k8s-worker.id
    tcp_options {
        destination_port_range {
            min = 6443
            max = 6443
        }
    }
}
resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_master_ingress_2379-2380" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-master.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "k8sワーカー to マスターノード用"
    source_type = "NETWORK_SECURITY_GROUP"
    source = oci_core_network_security_group.nsg_k8s-worker.id
    tcp_options {
        destination_port_range {
            min = 2379
            max = 2380
        }
    }
}
resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_master_ingress_10250" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-master.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "k8sワーカー to マスターノード用"
    source_type = "NETWORK_SECURITY_GROUP"
    source = oci_core_network_security_group.nsg_k8s-worker.id
    tcp_options {
        destination_port_range {
            min = 10250
            max = 10250
        }
    }
}
resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_master_ingress_10259" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-master.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "k8sワーカー to マスターノード用"
    source_type = "NETWORK_SECURITY_GROUP"
    source = oci_core_network_security_group.nsg_k8s-worker.id
    tcp_options {
        destination_port_range {
            min = 10259
            max = 10259
        }
    }
}
resource "oci_core_network_security_group_security_rule" "nsg_k8s-worker_master_ingress_10257" {
    network_security_group_id = oci_core_network_security_group.nsg_k8s-master.id
    direction = "INGRESS"
    protocol = "6" # TCP
    description = "k8sワーカー to マスターノード用"
    source_type = "NETWORK_SECURITY_GROUP"
    source = oci_core_network_security_group.nsg_k8s-worker.id
    tcp_options {
        destination_port_range {
            min = 10257
            max = 10257
        }
    }
}

