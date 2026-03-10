# variable compartment_ocid { default = "ocid1.compartment.oc1..aaaaaaaai5pgeen677gvw73yx6rslxfsfyrtmjk3yeuios6hakfzkl5vioiq" }
variable "compartment_ocid" { default = "ocid1.tenancy.oc1..aaaaaaaa2p5uw2myjiiowrtub5pcvgrwaqwnpi4fdtgy4x2r4ojrr4l672ga" }

variable "tenancy_ocid" { default = "ocid1.tenancy.oc1..aaaaaaaa2p5uw2myjiiowrtub5pcvgrwaqwnpi4fdtgy4x2r4ojrr4l672ga" }
# variable region { default = "ap-mumbai-1" }
variable "region" { default = "ap-hyderabad-1" }
variable "availability_domain" { default = "HfTn:AP-HYDERABAD-1-AD-1" }

#### networking ######
variable "cidr_block_public" { default = "192.168.2.0/24" }
variable "cidr_public_name" { default = "upyog_jenkins_public_subnet" }
variable "cidr_public_dns_label" { default = "public" }

variable "cidr_block_private" { default = "192.168.1.0/24" }
variable "cidr_private_name" { default = "oke_worker_private_subnet" }
variable "cidr_private_dns_label" { default = "private" }
variable "interet_gateway_display_name" { default = "upyog_jenkins_igw" }
variable "dhcp_display_name" { default = "Default DHCP Options for upyog_jenkins" }
variable "search_domain_names" { default = "upyogdev.oraclevcn.com" }
variable "vcn_cidr_blocks" { default = "192.168.0.0/16" }
variable "vcn_display_name" { default = "upyog_jenkins" }
variable "vcn_dns_label" { default = "upyogjenkins" }

variable "security_list_display_name" { default = "Default Security List for upyog_jenkins" }
variable "route_table_display_name" { default = "Default Route Table for upyog_jenkins" }

variable "cidr_LB_subnet" { default = "192.168.3.0/24" }
variable "LB_public_subnet_name" { default = "upyog_LB_jenkins_public_subnet" }
variable "LB_subnet_dns_label" { default = "LB" }

###################### OKE ##########
variable "oke_version" { default = "v1.34.1" }
variable "oke_name" { default = "upyog_oke_jenkins" }
variable "node_pool_name" { default = "upyog_jenkins_pool" }
variable "pod_cidr" { default = "10.244.0.0/16" }
variable "service_cidr" { default = "10.96.0.0/16" }
variable "node_pool_size" { default = "2" }


variable "oke_node_shape" { default = "VM.Standard.E4.Flex" }
### Oracle Linux ####
variable "oke_worker_node_image" { default = "Oracle-Linux-8.10-2025.06.17-0" }

######## Postgres ######################

#variable "postgre_private_subnet" { default = "192.168.4.0/24" }
#variable "postgre_private_subnet_name" { default = "postgre_private_subnet" }

#variable "postgre_public_subnet" { default = "192.168.5.0/24" }
#variable "postgre_public_subnet_name" { default = "postgre_public_subnet" }

# Provider identity parameters - Replace these values from API Key Values from OCI User


# compartment OCID - Replace these values

#variable "db_system_db_version" {
#  description = "Version"
#  type        = number
#  default     = 14
#}

#variable "db_system_display_name" {
#  description = "postgress db service name"
#  type        = string
#  default     = "upyog_dev_postgre" # example value
#}


#variable "db_system_shape" {
#  description = "shape"
#  type        = string
#  default     = "PostgreSQL.VM.Standard.E5.Flex.2.32GB" # example value
#  #change the shape value as per your requirements
#}

#variable "db_system_instance_count" {
#  description = "instance count"
#  type        = number
#  default     = 1 # example value
#}

#variable "db_system_instance_memory_size_in_gbs" {
#  description = "RAM"
#  type        = number
#  default     = 32 # example value
#}

#variable "db_system_instance_ocpu_count" {
#  description = "OCPU count"
#  type        = number
#  default     = 2 # example value
#}

#variable "db_system_storage_details_is_regionally_durable" {
#  description = "regional"
#  type        = bool
#  default     = false
#}
#variable "db_system_credentials_password_details_password_type" {
#  description = "type"
#  type        = string
#  default     = "PLAIN_TEXT"
#
#}
#
#variable "db_system_credentials_password_details_password" {
#  description = "password"
#  type        = string
#  default     = "Postgre@Oralce4upypog"
#}
#
#variable "db_system_credentials_username" {
#  description = "username"
#  type        = string
#  default     = "admin" # example value
#}
#
#variable "db_system_storage_details_system_type" {
#  description = "type"
#  type        = string
#  default     = "OCI_OPTIMIZED_STORAGE"
#}



# OCI VCN parameters - psql instance deployed on this

variable "public_subnet_cidr_block" {
  description = "subnet cidr range"
  type        = string
  default     = "172.16.1.0/24" # example value
}

variable "private_subnet_cidr_block" {
  description = "subnet cidr range"
  type        = string
  default     = "172.16.2.0/24" # example value
}

variable "public_subnet_display_name" {
  description = "public subnet name"
  type        = string
  default     = "public-subnet" # example value

}

variable "private_subnet_display_name" {
  description = "public subnet name"
  type        = string
  default     = "private-subnet" # example value

}

variable "internet_gateway_name" {
  description = "internet gateway name"
  type        = string
  default     = "internetgateway" # example value
}

variable "service_gateway_displayname" {
  description = "Service Gateway Display Name"
  type        = string
  default     = "servicegateway" # example value
}

variable "public_subnet_security_list_display_name" {
  description = "Public Subnet Security List Display Name"
  type        = string
  default     = "public_subnet_security_list" # example value
}

variable "private_subnet_security_list_display_name" {
  description = "Public Subnet Security List Display Name"
  type        = string
  default     = "public_subnet_security_list" # example value
}

variable "public_subnet_route_table_display_name" {
  description = "Public Subnet Route table Display Name"
  type        = string
  default     = "public_subnet_route_table" # example value
}

variable "private_subnet_route_table_display_name" {
  description = "Public Subnet Route table Display Name"
  type        = string
  default     = "private_subnet_route_table" # example value
}


# OCI Compute Instance parameters - We will use this instance to connect postgreSQL db instance

variable "compute_shape" {
  type    = string
  default = "VM.Standard.E4.Flex" # example value
}

variable "compute_cpus" {
  type    = string
  default = "1" # example value
}

variable "compute_memory_in_gbs" {
  type    = string
  default = "1" # example value
}

variable "compute_ssh_authorized_keys" {
  type    = string
  default = ""
}

variable "api_private_key_for_ssh" {
  type    = string
  default = ""
}

variable "source_operating_system_image_id" {
  description = "Oracle Linux 8 image ocid"
  type        = string
  default     = "ocid1.image.oc1.iad.aaaaaaaaszr5wpipg6qskiol3fhbitm56qdmumpbcpv6irzxuofi2nfmlhma" # example value
  # if you change the region , then change the default value from the region you have selected from this document -https://docs.oracle.com/en-us/iaas/images/image/998f1273-d4fd-4e16-8673-dd2517ddd724/
}

variable "compute_instance_display_name" {
  description = "display name of the compute name"
  type        = string
  default     = ""
}