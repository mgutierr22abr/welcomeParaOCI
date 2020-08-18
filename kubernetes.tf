data "oci_containerengine_node_pool_option" "op" {
	node_pool_option_id = "all"
	compartment_id = oci_identity_compartment.c1.id 
}

resource "oci_containerengine_cluster" "kube" {
  compartment_id = oci_identity_compartment.c1.id 
  kubernetes_version = data.oci_containerengine_node_pool_option.op.kubernetes_versions[length(data.oci_containerengine_node_pool_option.op.kubernetes_versions)-1]
  name = "${var.apodo}kube"
  vcn_id = oci_core_vcn.vcn1.id
  options {
   add_ons {
       is_kubernetes_dashboard_enabled = true
       is_tiller_enabled = true
       }
   kubernetes_network_config {
       pods_cidr     = "172.1.0.0/16"
       services_cidr = "172.2.0.0/16"
       }
   #service_lb_subnet_ids = [var.redsvc]
   }
}

resource "oci_containerengine_node_pool" "pool" {
	cluster_id = oci_containerengine_cluster.kube.id
	compartment_id = oci_identity_compartment.c1.id 
        kubernetes_version = data.oci_containerengine_node_pool_option.op.kubernetes_versions[length(data.oci_containerengine_node_pool_option.op.kubernetes_versions)-1]
	name = "${var.apodo}pool"
	node_image_name = data.oci_containerengine_node_pool_option.op.images[length(data.oci_containerengine_node_pool_option.op.images)-1]
	node_shape = "VM.Standard2.1"
	ssh_public_key = var.ssh_public_key
        node_config_details {
          placement_configs {
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
            subnet_id           = oci_core_subnet.subnet1.id
          }
          size = 1
        }
}

data "oci_containerengine_cluster_kube_config" "kube_config" {
  cluster_id = oci_containerengine_cluster.kube.id
  expiration = 0
  #token_version = "1.0.0"
}

resource "local_file" "kube_config_file" {
  content     = data.oci_containerengine_cluster_kube_config.kube_config.content
  filename = "${path.module}/config-kube.txt"
}

resource "local_file" "poolid" {
  content     = oci_containerengine_node_pool.pool.id
  filename = "${path.module}/poolid.txt"
}
