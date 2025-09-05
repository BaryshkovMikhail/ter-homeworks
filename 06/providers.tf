terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.155.0"
    }
  }
  backend "s3" {
    bucket = "woland.tfstate"
    key    = "terraform.tfstate"
    region = "ru-central1"

    endpoints = {
      s3       = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g8dhkoksraemsg21d1/etni3ipa24vqis2bv069"
    }

    dynamodb_table = "tfstate-lock"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
  required_version = "~> 1.8.4"
}

provider "yandex" {
  cloud_id                = var.cloud_id
  folder_id               = var.folder_id
  zone                    = var.default_zone
  service_account_key_file = var.service_account_key_file
}