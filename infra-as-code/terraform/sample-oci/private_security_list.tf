# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list

resource "oci_core_security_list" "private-security-list"{
  # provider = oci.HYD

# Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id

# Optional
  display_name = "DJB-EDP-LZ-UPYOG-DEV-SL-PRIVATE-SUBNET-BOM"

    egress_security_rules {
      stateless = false
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol = "all" 
  }

    ingress_security_rules { 
      stateless = false
      source = var.vcn_cidr_blocks
      source_type = "CIDR_BLOCK"
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
      protocol = "6"
      tcp_options { 
          min = 22
          max = 22
      }
    }
  ingress_security_rules { 
      stateless = false
      source = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
      protocol = "1"
  
      # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
      icmp_options {
        type = 3
        code = 4
      } 
    }   
  
  ingress_security_rules { 
      stateless = false
      source = var.vcn_cidr_blocks
      source_type = "CIDR_BLOCK"
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
      protocol = "1"
  
      # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
      icmp_options {
        type = 3
      } 
    }
}


#### Security List for PostgreSQL Private Subnet #######
resource "oci_core_security_list" "PG-security-list"{
  # provider = oci.HYD

# Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id

# Optional
  display_name = "DJB-EDP-LZ-UPYOG-DEV-SL-PG-PRIVATE-SUBNET-BOM"

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
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
      protocol = "6"
      tcp_options { 
          min = 5432
          max = 5432
      }
    }

}



