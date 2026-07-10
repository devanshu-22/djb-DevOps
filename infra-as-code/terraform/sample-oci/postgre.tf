resource "oci_psql_db_system" "upyog_db_system" {
    #Required
    compartment_id = var.compartment_ocid
    db_version = var.db_system_db_version
    display_name = var.db_system_display_name
    network_details {
        #Required
        subnet_id = oci_core_subnet.postgre_private_subnet.id
    }
    shape = var.db_system_shape
    storage_details {
        #Required
        is_regionally_durable = var.db_system_storage_details_is_regionally_durable
        system_type = var.db_system_storage_details_system_type
        #Optional
        #availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
        availability_domain = var.availability_domain
        # iops = var.db_system_storage_details_iops
    }
    credentials {
        #Required
        password_details {
            #Required
            password_type = var.db_system_credentials_password_details_password_type
            #Optional
            password = var.db_system_credentials_password_details_password
        }
        username = var.db_system_credentials_username
    }
    instance_count = var.db_system_instance_count
    instance_memory_size_in_gbs = var.db_system_instance_memory_size_in_gbs
    instance_ocpu_count = var.db_system_instance_ocpu_count

}

data "oci_psql_db_system_connection_detail" "postgreSQL_db_system_connection_detail" {
    #Required
    db_system_id = oci_psql_db_system.upyog_db_system.id
}


