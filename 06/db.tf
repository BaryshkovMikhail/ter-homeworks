# 1. Кластер БД (без указания базы данных)
resource "yandex_mdb_mysql_cluster" "db" {
  name        = "mysql-cluster"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.main.id
  version     = "8.0"

  host {
    zone      = var.default_zone
    subnet_id = yandex_vpc_subnet.main.id
  }

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }
}

# 2. Отдельно создаем базу данных
resource "yandex_mdb_mysql_database" "db" {
  cluster_id = yandex_mdb_mysql_cluster.db.id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "db_user" {
  cluster_id = yandex_mdb_mysql_cluster.db.id
  name       = var.db_user
  password   = var.db_password  # или из LockBox, если нужно

  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = ["ALL"]
  }
}