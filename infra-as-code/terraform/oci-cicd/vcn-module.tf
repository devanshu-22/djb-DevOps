# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.6.0"
  # insert the 1 required variable here

  # Required Inputs
  compartment_id = oci_identity_compartment.create-compartment.id

  # Optional Inputs 
  region = var.region
  # providers = {
  #   oci = oci.HYD
  # }

  # Changing the following default values
  vcn_name                = "upyog-jenkins"
  create_internet_gateway = true
  create_nat_gateway      = true
  create_service_gateway  = true

  # Using the following default values
  vcn_dns_label = "upyog"
  vcn_cidrs     = [var.vcn_cidr_blocks]
}