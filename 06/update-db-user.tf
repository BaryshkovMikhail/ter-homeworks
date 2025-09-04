resource "yandex_mdb_mysql_user" "db_user" {
  cluster_id = yandex_mdb_mysql_cluster.db.id
  name       = var.db_user
  password   = data.yandex_lockbox_secret_version.db_password.payload[0].text_value
  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = ["ALL"]
  }
}