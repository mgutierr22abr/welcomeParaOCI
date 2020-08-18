resource "oci_core_vcn" "vcn1" {
  cidr_block     = var.subnetglobal
  dns_label      = var.apodo
  compartment_id = oci_identity_compartment.c1.id
  display_name   = var.apodo
}

resource "oci_core_subnet" "subnet1" {
  cidr_block          = var.resumen[1]
  display_name        = "${var.apodo}-${var.resumen[0]}"
  dns_label           = var.resumen[0]
  compartment_id      = oci_identity_compartment.c1.id
  vcn_id              = oci_core_vcn.vcn1.id
  security_list_ids   = [oci_core_security_list.seclist.id]
  route_table_id      = oci_core_route_table.publicRoute.id
  dhcp_options_id     = oci_core_vcn.vcn1.default_dhcp_options_id
}

resource "oci_core_security_list" "seclist" {
  compartment_id = oci_identity_compartment.c1.id
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "${var.apodo}sl"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false
    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false
    tcp_options {
      min = 30300
      max = 30300
    }
  }
}

resource "oci_core_internet_gateway" "ig" {
    compartment_id = oci_identity_compartment.c1.id
    display_name = "${var.apodo}ig"
    vcn_id = oci_core_vcn.vcn1.id
}

resource "oci_core_route_table" "publicRoute" {
  compartment_id = oci_identity_compartment.c1.id 
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "${var.apodo}publicroute"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}
