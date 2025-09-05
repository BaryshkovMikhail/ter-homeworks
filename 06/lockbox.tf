resource "yandex_lockbox_secret" "db_password" {
  name = var.db_password_secret_name
}

resource "yandex_lockbox_secret_version" "db_password" {
  secret_id = yandex_lockbox_secret.db_password.id
  entries {
    key        = "password"
    text_value = var.db_password
  }
}

