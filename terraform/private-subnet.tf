resource "oci_core_subnet" "priv-sub_k8s"{

  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn_k8s.id
  cidr_block = "10.0.0.0/24"

  route_table_id = oci_core_default_route_table.default-route-table.id
  security_list_ids = [oci_core_default_security_list.psl_k8s.id]
  display_name = "k8s-cluster"
}