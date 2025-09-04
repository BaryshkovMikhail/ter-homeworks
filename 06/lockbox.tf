resource "yandex_lockbox_secret" "db_password" {
  name = var.db_password_secret_name
}

resource "yandex_lockbox_secret_version" "db_password" {
  secret_id = yandex_lockbox_secret.db_password.id
  entries {
    key   = "password"
    value = var.db_password
  }
}

data "yandex_lockbox_secret_version" "db_password" {
  secret_id = yandex_lockbox_secret.db_password.id
}