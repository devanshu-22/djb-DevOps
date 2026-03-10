module "oke" {
    source  = "oracle-terraform-modules/oke/oci"
    version = "5.3.2"
    compartment_id = oci_identity_compartment.create-compartment.id
    tenancy_id = var.tenancy_ocid
    providers = {
      oci.home = oci.HYD
    }

    ### Cluster ####
    create_cluster = true
    cluster_name = "upyog-jenkins"
    cluster_type = "enhanced"

    control_plane_is_public = true
    assign_public_ip_to_control_plane = true
    cni_type = "flannel"
    kubernetes_version = var.oke_version

    ### Network
    create_vcn = false
    vcn_id = module.vcn.vcn_id
    vcn_create_nat_gateway = "never"
    vcn_create_internet_gateway = "never"
    vcn_create_service_gateway = "never"
    internet_gateway_id = module.vcn.internet_gateway_id
    ig_route_table_id = module.vcn.ig_route_id
    nat_gateway_id = module.vcn.nat_gateway_id
    nat_route_table_id = module.vcn.nat_route_id
    # load_balancers = "public"

    lockdown_default_seclist = false
    # nat_gateway_route_rules = "false"

    subnets = {
        bastion  = { create = "never" }
        operator = { create = "never" }
        cp       = { create = "never", id = oci_core_subnet.vcn-public-subnet.id}
        int_lb   = { create = "never" }
        pub_lb   = { create = "never", id = oci_core_subnet.LB-public-subnet.id }
        workers  = { create = "never", id = oci_core_subnet.vcn-private-subnet.id }
        pods     = { create = "never" }
    }


    nsgs = {
        bastion  = {create = "never"}
        operator = {create = "never"}
        cp       = {create = "never"}
        int_lb   = {create = "never"}
        pub_lb   = {create = "never"}
        workers  = {create = "never"}
        pods     = {create = "never"}
    }

    # vcn_cidrs = var.vcn_cidr_blocks
    # vcn_dns_label = var.vcn_dns_label
    allow_worker_internet_access = false
    allow_pod_internet_access = false

    ### security
    create_bastion = false

    ## Worker Node ####
    worker_pools = {
        upyog-jenkins = {
            description = "OKE-managed Node Pool with OKE Oracle Linux 8 image"
        }
    }
    worker_pool_mode = "node-pool"
    worker_pool_size = var.node_pool_size
    worker_is_public = false
    # worker_node_labels = var.node_pool_name
    worker_shape = {
        shape            = "VM.Standard.E3.Flex"
        ocpus            = 2
        memory           = 32
        boot_volume_size = 200
        boot_volume_vpus_per_gb = 10
    }

    output_detail = false
}

