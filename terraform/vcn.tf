resource "oci_core_vcn" "vcn_k8s" {
  compartment_id = var.compartment_id
  display_name = "k8s-cluster"
  cidr_block = "10.0.0.0/16"
  dns_label = "vcnmodule"
}

resource "oci_core_internet_gateway" "inet-gw-k8s" {
  compartment_id = var.compartment_id
  display_name   = "k8s-cluster"
  vcn_id         = oci_core_vcn.vcn_k8s.id
}

resource "oci_core_default_dhcp_options" "default-dhcp-options" {
  manage_default_resource_id = oci_core_vcn.vcn_k8s.default_dhcp_options_id

  #Required
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
}

resource "oci_core_default_route_table" "default-route-table" {
  manage_default_resource_id = oci_core_vcn.vcn_k8s.default_route_table_id

  #Required
  compartment_id = var.compartment_id

  #Optional
  display_name = "k8s-cluster"
  route_rules {

    #Required
    network_entity_id = oci_core_internet_gateway.inet-gw-k8s.id

    #Optional
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}