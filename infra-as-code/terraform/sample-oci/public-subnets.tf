# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "vcn-public-subnet"{

  # Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  cidr_block = var.cidr_block_public
 
  # Optional
  route_table_id = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id, oci_core_security_list.k8s_api_endpoint.id]
  display_name = var.public_subnet_display_name
}

resource "oci_core_subnet" "LB-public-subnet"{

  # Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  cidr_block = var.cidr_LB_subnet
 
  # Optional
  route_table_id = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name = var.LB_public_subnet_name
}

resource "oci_core_subnet" "postgre_public_subnet"{

  # Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  cidr_block = var.postgre_public_subnet
 
  # Optional
  route_table_id = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name = var.postgre_public_subnet_name
}

data "oci_core_subnet" "oke_endpoint_subnet" {
  subnet_id = oci_core_subnet.vcn-public-subnet.id
}

data "oci_core_subnet" "LB-public-subnet" {
  subnet_id = oci_core_subnet.LB-public-subnet.id
}

data "oci_core_subnet" "postgre_public_subnet" {
  subnet_id = oci_core_subnet.postgre_public_subnet.id
}