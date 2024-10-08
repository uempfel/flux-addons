locals {
  environments_map = { for v in var.config.clusters : v.stage => v }
}

resource "kind_cluster" "this" {
  for_each       = local.environments_map
  name           = each.value.name
  node_image     = each.value.node_image
  wait_for_ready = each.value.wait_for_ready

  # kind_config {
  #   kind        = try(each.value.kind_config.kind, null)
  #   api_version = try(each.value.kind_config.apiVersion, null)

  #   dynamic "node" {
  #     for_each = each.value.kind_config.nodes

  #     content {
  #       role                   = try(node.value.role, null)
  #       kubeadm_config_patches = try(node.value.kubeadmConfigPatches, null)

  #       dynamic "extra_port_mappings" {
  #         for_each = toset(node.value.extraPortMappings)
  #         #iterator = "value"
  #         content {
  #           container_port = try(extra_port_mappings.value.containerPort, null)
  #           host_port      = try(extra_port_mappings.value.hostPort, null)
  #           protocol       = try(extra_port_mappings.value.protocol, null)
  #         }
  #       }
  #     }

  #   }
  # }
}


resource "github_repository" "this" {
  name        = var.name
  description = var.name
  visibility  = "public"
  auto_init   = true # This is extremely important as flux_bootstrap_git will not work without a repository that has been initialised
}

resource "null_resource" "flux_bootstrap" {
  for_each = local.environments_map
  provisioner "local-exec" {
    environment = {
      "GITHUB_TOKEN" = var.github_token
    }
    when        = create
    quiet       = true
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOF
    flux bootstrap github --owner=${var.github_org} --repository=${var.name} --private=false --personal=true --path=clusters/${each.value.stage} --cluster=kind-${each.value.name}
    EOF
  }
  depends_on = [
    kind_cluster.this,
    github_repository.this,
    github_repository_file.this
  ]
}
