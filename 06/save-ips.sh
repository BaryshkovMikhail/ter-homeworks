#!/bin/bash
# save-ips.sh — запускать после terraform apply

echo "Ожидание завершения apply..."
terraform output -json > output.json

echo "Создание файла ips.txt..."

jq -r '
"=== IP-адреса инфраструктуры ===
ВМ (внешний IP): \(.vm_external_ip.value)
ВМ (внутренний IP): \(.vm_internal_ip.value)
MySQL (внутренний IP): \(.mysql_internal_ip.value)
Container Registry ID: \(.registry_id.value)
" 
' output.json > ips.txt

cat ips.txt

echo "✅ Файл ips.txt создан!"