# Outputs for compartment

#output "compartment-name" {
#  value = oci_identity_compartment.create-compartment.name
#}

output "compartment-OCID" {
  value = var.compartment_ocid
}
output "availability_domain" {
  value = var.availability_domain
}

# Outputs for the vcn module

output "vcn_id" {
  description = "OCID of the VCN that is created"
  value = module.vcn.vcn_id
}
output "id-for-route-table-that-includes-the-internet-gateway" {
  description = "OCID of the internet-route table. This route table has an internet gateway to be used for public subnets"
  value = module.vcn.ig_route_id
}
output "nat-gateway-id" {
  description = "OCID for NAT gateway"
  value = module.vcn.nat_gateway_id
}
output "id-for-for-route-table-that-includes-the-nat-gateway" {
  description = "OCID of the nat-route table - This route table has a nat gateway to be used for private subnets. This route table also has a service gateway."
  value = module.vcn.nat_route_id
}

# Outputs for private security list

output "private-security-list-name" {
  value = oci_core_security_list.private-security-list.display_name
}
output "private-security-list-OCID" {
  value = oci_core_security_list.private-security-list.id
}

# Outputs for public security list

output "public-security-list-name" {
  value = oci_core_security_list.public-security-list.display_name
}
output "public-security-list-OCID" {
  value = oci_core_security_list.public-security-list.id
}

# Outputs for private subnet

output "private-subnet-name" {
  value = oci_core_subnet.vcn-private-subnet.display_name
}
output "private-subnet-OCID" {
  value = oci_core_subnet.vcn-private-subnet.id
}

# Outputs for public subnet

output "public-subnet-name" {
  value = oci_core_subnet.vcn-public-subnet.display_name
}
output "public-subnet-OCID" {
  value = oci_core_subnet.vcn-public-subnet.id
}

output "LB-subnet-name" {
  value = oci_core_subnet.LB-public-subnet.display_name
}
output "LB-subnet-OCID" {
  value = oci_core_subnet.LB-public-subnet.id
}
###
output "postgreSQL" {
  value = oci_psql_db_system.upyog_db_system.instances
  
}

output "postgreSQL_Network" {
  value = oci_psql_db_system.upyog_db_system.network_details
}

output "postgreSQL_description" {
  value = data.oci_psql_db_system_connection_detail.postgreSQL_db_system_connection_detail
}

output "Cluster_Name" {
  # value = oci_containerengine_cluster.generated_oci_containerengine_cluster.endpoint_config
  value = module.oke.cluster_id
}

output "Cluster_endpoints" {
  # value = oci_containerengine_cluster.generated_oci_containerengine_cluster.endpoints
  value = module.oke.cluster_endpoints
}

output "Node_Pool" {
  # value = oci_containerengine_node_pool.create_node_pool_details.node_config_details
  value = module.oke.worker_pools
}

output "Kubeconfig" {
  value = module.oke.cluster_kubeconfig
}

###### block volumes

output "es-master" {
  value = oci_core_volume.es-master[*].id
  
}
output "es-data-id" {
  value = oci_core_volume.es-data-v1[*].id
  
}
output "zookeeper" {
  value = oci_core_volume.zookeeper[*].id
  
}
output "kafka" {
  value = oci_core_volume.kafka[*].id
  
}