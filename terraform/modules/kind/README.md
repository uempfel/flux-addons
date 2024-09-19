<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.1 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | >= 0.6 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.1 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | >= 0.6 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_file.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [kind_cluster.this](https://registry.terraform.io/providers/tehcyx/kind/latest/docs/resources/cluster) | resource |
| [null_resource.flux_bootstrap](https://registry.terraform.io/providers/hashicorp/null/3.2.3/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | <pre>object({<br>    clusters = list(object({<br>      addon_config = optional(object({<br>        enable_ingress_nginx = optional(bool, false)<br>        enable_metrics_server = optional(bool, false)<br>        enable_observability = optional(bool, false)<br>        enable_cert_manager = optional(bool, false)<br>      }), null)<br>      stage          = string<br>      name           = string<br>      node_image     = string<br>      wait_for_ready = bool<br>      kind_config = optional(object({<br>        kind       = string<br>        apiVersion = string<br>        #kubeadmConfigPatches = list(string)<br>        nodes = list(object({<br>          role                 = string<br>          kubeadmConfigPatches = list(string)<br>          extraPortMappings = list(object({<br>            containerPort = string<br>            hostPort      = string<br>            protocol      = string<br>          }))<br>        }))<br>      }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organization | `string` | `"uempfel"` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | GitHub repository | `string` | `""` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub token | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for cluster and GitHub project | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->