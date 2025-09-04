resource "yandex_mdb_mysql_cluster" "db" {
  name        = "mysql-cluster"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.main.id

  host {
    zone      = var.default_zone
    subnet_id = yandex_vpc_subnet.main.id
  }

  resource_preset_id = "db-parking-1"
  disk_type_id       = "network-ssd"
  disk_size          = 20

  user {
    name     = var.db_user
    password = "placeholder"
    permission {
      database_name = var.db_name
      roles         = ["ALL"]
    }
  }

  database {
    name = var.db_name
  }
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = yandex_mdb_mysql_cluster.db.id
  name       = var.db_name
}