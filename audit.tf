data "oci_audit_events" "audit_events" {
  compartment_id = oci_identity_compartment.c1.id
  start_time = timeadd(timestamp(), "-10m")
  end_time = timestamp()
  depends_on = [ oci_database_autonomous_database.databasea ]
}
