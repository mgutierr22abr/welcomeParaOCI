resource "oci_identity_policy" "poke" {
  name           = "okePolicy"
  description    = "politicas de seguridad OKE"
  compartment_id = var.tenancy_ocid
  statements = [ 
"allow service OKE to manage all-resources in tenancy",
"allow service OKE to manage load-balancers in tenancy",
]
}
