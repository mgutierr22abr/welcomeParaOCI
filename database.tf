resource "oci_database_autonomous_database" "databasea" {
  admin_password           = "Welcome#1#1#1"
  compartment_id           = oci_identity_compartment.c1.id 
  cpu_core_count           = 1
  data_storage_size_in_tbs = 1
  db_name                  = "usage"
  db_workload              = "DW" # OLTP / DW / JSON
  display_name             = "usage"
  is_dedicated             = false
  is_auto_scaling_enabled  = false
  license_model            = "LICENSE_INCLUDED"
  is_preview_version_with_service_terms_accepted = false
  #whitelisted_ips = ["192.168.0.0/24","10.0.0.0/24"]
}

data "oci_database_autonomous_database_wallet" "autonomous_database_wallet" {
  autonomous_database_id = oci_database_autonomous_database.databasea.id
  password               = "Welcome#1#1#1"
  base64_encode_content  = "true"
}

resource "local_file" "wallet_file" {
  content_base64 = data.oci_database_autonomous_database_wallet.autonomous_database_wallet.content
  filename       = "${path.module}/wallet.zip"
}

resource "local_file" "dbid" {
  content_base64 = data.oci_database_autonomous_database_wallet.autonomous_database_wallet.content
  filename       = "${path.module}/dbid.txt"
}

resource "local_file" "apexurl" {
  content = replace( oci_database_autonomous_database.databasea.connection_urls[0].apex_url,"apex","f?p=100")
  filename = "${path.module}/apexurl.txt"
}
