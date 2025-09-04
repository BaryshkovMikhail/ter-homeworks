terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.155.0"
    }
  }
   backend "s3" {
     bucket   = "woland.tfstate"
     endpoints = {s3 = "https://storage.yandexcloud.net" }
     key      = "terraform.tfstate"
     region   = "ru-central1"
     # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
     # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!

     dynamodb_table    = "tfstate-lock" #таблица блокировок
     dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g8dhkoksraemsg21d1/etni3ipa24vqis2bv069"

     skip_region_validation      = true
     skip_credentials_validation = true
     skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
     skip_s3_checksum             = true
   }
  required_version = "~>1.8.4"
}



provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.authorized_key.json")
}
