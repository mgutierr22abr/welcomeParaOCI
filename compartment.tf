resource "oci_identity_compartment" "c1" {
  name           = var.apodo
  description    = "Compartment para Herramientas de Ejemplo"
  compartment_id = var.tenancy_ocid
  enable_delete  = true       // para poder eliminar con  `terrafrom destroy`
}
resource "oci_identity_compartment" "c2" {
  name           = "sandbox"
  description    = "Compartment Sandbox de Pruebas"
  compartment_id = var.tenancy_ocid
  enable_delete  = true
}
resource "local_file" "tenancy" {
  content        = oci_identity_compartment.c1.compartment_id
  filename       = "${path.module}/compid.txt"
}

