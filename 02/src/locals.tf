locals {
  # Общая префиксная часть имени ВМ
  vm_name_prefix = "netology-develop-platform"

  # Имена ВМ с использованием интерполяции
  vm_web_name = "${local.vm_name_prefix}-web"
  vm_db_name  = "${local.vm_name_prefix}-db"
}