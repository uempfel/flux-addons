# flux-gitops-addons
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.1 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | >= 0.6 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kind_clusters"></a> [kind\_clusters](#module\_kind\_clusters) | ./modules/kind | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_pat"></a> [github\_pat](#input\_github\_pat) | GitHub personal access token | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->