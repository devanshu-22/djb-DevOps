# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list
data "oci_core_services" "all_mumbai_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}


resource "oci_core_security_list" "k8s_api_endpoint"{

# Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  display_name   = "DJB-EDP-LZ-UPYOG-DEV-SL-K8S-API-ENDPOINT-BOM"

# Optional

  ingress_security_rules {
    protocol    = "6"  # TCP
    source      = var.cidr_block_private
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 6443
      max = 6443
    }
    description = "Worker Nodes to Kubernetes API endpoint (TCP/6443)"
    stateless   = false
  }

    ingress_security_rules {
    protocol    = "6"  # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 6443
      max = 6443
    }
    description = "internet to Kubernetes API endpoint (TCP/6443)"
    stateless   = false
  }


  ingress_security_rules {
    protocol    = "6"
    source      = var.cidr_block_private
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 12250
      max = 12250
    }
    description = "Worker Nodes to Kubernetes API endpoint (TCP/12250)"
    stateless   = false
  }

  ingress_security_rules {
    protocol    = "6"
    source      = var.pod_cidr
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 6443
      max = 6443
    }
    description = "Pods to Kubernetes API endpoint (TCP/6443)"
    stateless   = false
  }

  ingress_security_rules {
    protocol    = "6"
    source      = var.pod_cidr
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 12250
      max = 12250
    }
    description = "Pods to Kubernetes API endpoint (TCP/12250)"
    stateless   = false
  }

  ingress_security_rules {
    protocol    = "1"  # ICMP
    source      = var.cidr_block_private
    source_type = "CIDR_BLOCK"
    icmp_options {
      type = 3
      code = 4
    }
    description = "Worker Nodes, ICMP 3/4 (Path Discovery)"
    stateless   = false
  }

  egress_security_rules {
    protocol           = "6"  # TCP
    destination        = data.oci_core_services.all_mumbai_services.services[0].cidr_block  # Example: "all-phx-services-in-oracle-services-network"
    destination_type   = "SERVICE_CIDR_BLOCK"
    tcp_options {
      min = 443
      max = 443
    }
    description        = "Allow Kubernetes API endpoint to communicate with OKE (TCP/443)"
    stateless          = false
  }

  egress_security_rules {
    protocol           = "6"
    destination        = var.cidr_block_private
    destination_type   = "CIDR_BLOCK"
    description        = "All traffic to worker nodes (when using flannel for pod networking)"
    stateless          = false
  }

  egress_security_rules {
    protocol           = "all"
    destination        = var.pod_cidr
    destination_type   = "CIDR_BLOCK"
    description        = "Kubernetes API endpoint to pod communication (VCN-native pod networking)"
    stateless          = false
  }

  egress_security_rules {
    protocol           = "1"  # ICMP
    destination        = var.cidr_block_private
    destination_type   = "CIDR_BLOCK"
    icmp_options {
      type = 3
      code = 4
    }
    description        = "Worker Nodes ICMP 3/4 (Path Discovery)"
    stateless          = false
  }

  egress_security_rules {
    protocol           = "6"  # TCP
    destination        = var.cidr_block_private
    destination_type   = "CIDR_BLOCK"
    tcp_options {
      min = 10250
      max = 10250
    }
    description        = "API endpoint to worker node communication (TCP/10250, VCN-native pod networking)"
    stateless          = false
  }

    egress_security_rules {
    protocol           = "6"  # TCP
    destination        = "0.0.0.0/0"
    destination_type   = "CIDR_BLOCK"
    tcp_options {
      min = 6443
      max = 6443
    }
    description        = "API endpoint to Internet)"
    stateless          = false
  }

  egress_security_rules {
    protocol           = "1"  # ICMP
    destination        = var.cidr_block_private
    destination_type   = "CIDR_BLOCK"
    description        = "API endpoint to worker node communication (ICMP, VCN-native pod networking)"
    stateless          = false
  }
}


#### worker nodes

resource "oci_core_security_list" "oke_worker_nodes_sl" {
# Required
  compartment_id = var.compartment_ocid
  vcn_id = module.vcn.vcn_id
  display_name   = "DJB-EDP-LZ-UPYOG-DEV-SL-WorkerNodes-BOM"

  # 1. Worker Nodes CIDR <-> Worker Nodes CIDR (ALL traffic)
  ingress_security_rules {
    protocol    = "all"
    source      = var.cidr_block_private
    source_type = "CIDR_BLOCK"
  }

  # 2. Pods CIDR <-> Pods CIDR (ALL traffic, VCN-native pods)
  ingress_security_rules {
    protocol    = "all"
    source      = var.pod_cidr
    source_type = "CIDR_BLOCK"
  }

  # 3. Kubernetes API Endpoint CIDR -> Worker Nodes (ALL TCP)
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = var.cidr_LB_subnet
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 1
      max = 65535
    }
  }

  # 4. Path MTU Discovery (ICMP type 3, code 4)
  ingress_security_rules {
    protocol    = "1" # ICMP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    icmp_options {
      type = 3
      code = 4
    }
  }

  # 5a. K8s API Endpoint CIDR -> Worker Nodes (TCP 10250)
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = var.cidr_LB_subnet
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 10250
      max = 10250
    }
  }

  # 5b. K8s API Endpoint CIDR -> Worker Nodes (ICMP)
  ingress_security_rules {
    protocol    = "1" # ICMP
    source      = var.cidr_LB_subnet
    source_type = "CIDR_BLOCK"
  }

  # Egress: Allow all traffic out (stateful return traffic + image pulls, etc.)
      ### --- EGRESS RULES ---

  # 1. Worker Nodes CIDR (ALL traffic)
  egress_security_rules {
    protocol            = "all"
    destination         = var.cidr_block_private
    destination_type    = "CIDR_BLOCK"
  }

  # 2. Pods CIDR (ALL traffic)
  egress_security_rules {
    protocol            = "all"
    destination         = var.pod_cidr
    destination_type    = "CIDR_BLOCK"
  }

  # 3. Path MTU Discovery (ICMP type 3, code 4)
  egress_security_rules {
    protocol            = "1" # ICMP
    destination         = "0.0.0.0/0"
    destination_type    = "CIDR_BLOCK"
    icmp_options {
      type = 3
      code = 4
    }
  }

  # 4. Oracle Services Network (all <region> services, e.g. OKE, Object Storage, Registry, etc.)
  egress_security_rules {
    protocol            = "6" # TCP
    destination         = data.oci_core_services.all_mumbai_services.services[0].cidr_block
    destination_type    = "SERVICE_CIDR_BLOCK"
  }

  # 5. Kubernetes API Endpoint CIDR (TCP 6443)
  egress_security_rules {
    protocol            = "6" # TCP
    destination         = var.cidr_LB_subnet
    destination_type    = "CIDR_BLOCK"
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  # 6. Kubernetes API Endpoint CIDR (TCP 12250)
  egress_security_rules {
    protocol            = "6" # TCP
    destination         = var.cidr_LB_subnet
    destination_type    = "CIDR_BLOCK"
    tcp_options {
      min = 12250
      max = 12250
    }
  }
}





