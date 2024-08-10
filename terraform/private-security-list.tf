resource "oci_core_default_security_list" "psl_k8s"{
  manage_default_resource_id = oci_core_vcn.vcn_k8s.default_security_list_id

  display_name = "k8s-cluster"

  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "all" 
  }

  ingress_security_rules { 
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 22
        max = 22
    }
  }

  ingress_security_rules { 
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "1" #icmp

    icmp_options {
      type = 3
      code = 4
    } 
  }   
  
  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "1" #icmp

    icmp_options {
      type = 3
    } 
  }

  # k8s ports -- start
  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 6443
        max = 6443
    }
  }

  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 2359
        max = 2380
    }
  }

  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 10250
        max = 10250
    }
  }

  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 10259
        max = 10259
    }
  }

  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 10257
        max = 10257
    }
  }

  ingress_security_rules { 
    stateless = false
    source = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    protocol = "6" #tcp

    tcp_options { 
        min = 30000
        max = 32767
    }
  }
  # k8s ports -- end
}