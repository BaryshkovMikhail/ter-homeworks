## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.8.4 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_analytics_vm"></a> [analytics\_vm](#module\_analytics\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_marketing_vm"></a> [marketing\_vm](#module\_marketing\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc_dev"></a> [vpc\_dev](#module\_vpc\_dev) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id | `string` | n/a | yes |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | https://cloud.yandex.ru/docs/vpc/operations/subnet-create | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | https://cloud.yandex.ru/docs/overview/concepts/geo-scope | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token | `string` | n/a | yes |
| <a name="input_vm_db_name"></a> [vm\_db\_name](#input\_vm\_db\_name) | example vm\_db\_ prefix | `string` | `"netology-develop-platform-db"` | no |
| <a name="input_vm_web_name"></a> [vm\_web\_name](#input\_vm\_web\_name) | example vm\_web\_ prefix | `string` | `"netology-develop-platform-web"` | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen -t ed25519 | `string` | `"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF5fK+g2KVk8M7DcnxENYKsmnx4J4ryLHjCJeMwjf3fZ m.baryshkov@mail.ru"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network&subnet name | `string` | `"develop"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analytics_vm_fqdn"></a> [analytics\_vm\_fqdn](#output\_analytics\_vm\_fqdn) | n/a |
| <a name="output_analytics_vm_public_ip"></a> [analytics\_vm\_public\_ip](#output\_analytics\_vm\_public\_ip) | n/a |
| <a name="output_marketing_vm_fqdn"></a> [marketing\_vm\_fqdn](#output\_marketing\_vm\_fqdn) | outputs.tf |
| <a name="output_marketing_vm_public_ip"></a> [marketing\_vm\_public\_ip](#output\_marketing\_vm\_public\_ip) | n/a |
