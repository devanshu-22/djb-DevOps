resource "oci_core_subnet" "vcn-private-subnet"{

  # Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  cidr_block = var.cidr_block_private
  prohibit_public_ip_on_vnic = true
  # Optional
  # Caution: For the route table id, use module.vcn.nat_route_id.
  # Do not use module.vcn.nat_gateway_id, because it is the OCID for the gateway and not the route table.
  route_table_id = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.private-security-list.id, oci_core_security_list.oke_worker_nodes_sl.id]
  display_name = var.private_subnet_display_name
}

resource "oci_core_subnet" "postgre_private_subnet"{

  # Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  cidr_block = var.postgre_private_subnet
  prohibit_public_ip_on_vnic = true
  # Optional
  # Caution: For the route table id, use module.vcn.nat_route_id.
  # Do not use module.vcn.nat_gateway_id, because it is the OCID for the gateway and not the route table.
  route_table_id = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.private-security-list.id, oci_core_security_list.PG-security-list.id]
  display_name = var.postgre_private_subnet_name
}

data "oci_core_subnet" "worker_node_subnet" {
  subnet_id = oci_core_subnet.vcn-private-subnet.id
}

data "oci_core_subnet" "postgre_private_subnet" {
  subnet_id = oci_core_subnet.postgre_private_subnet.id
}
