variable "apodo" {}
variable "subnetglobal" {}
variable "resumen" {type    = list}

variable "tenancy_ocid" {}
variable "region" {}
variable "ssh_public_key" {}


/******************************************************/
provider "oci" {
   auth = "InstancePrincipal"  
   region = var.region
}
/******************************************************/

data "oci_identity_tenancy" "tenancy" {
        tenancy_id = "${var.tenancy_ocid}"
}

/******************************************************/
data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}
/******************************************************/
data "oci_containerengine_node_pool_option" "opciones" {
	node_pool_option_id = "all"
}
