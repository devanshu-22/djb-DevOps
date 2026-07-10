resource "oci_core_volume" "es-master" {
  #availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "es-master"
  count = 3
  size_in_gbs = "50"
}

resource "oci_core_volume" "es-data-v1" {
  #availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "es-data-v1"
  count = 3
  size_in_gbs = "50"
}

resource "oci_core_volume" "zookeeper" {
  #availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "zookeeper"
  count = 3
  size_in_gbs = "50"
}


resource "oci_core_volume" "kafka" {
  #availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "kafka"
  size_in_gbs = "50"
  count = 3
}