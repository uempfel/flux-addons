locals {
  flux_fileset = fileset("${path.module}/files/flux", "**")
  flux_files_helper = flatten([
    for stage, details in local.environments_map : [
      for file_path in local.flux_fileset : {
        local_file_path = file_path,
        repo_file_path  = "clusters/${stage}/${trimsuffix(file_path, ".tpl")}",
        stage           = stage
      }
    ]
  ])
  flux_files_map = { for entry in local.flux_files_helper : entry.repo_file_path => entry }
}


# resource "gitlab_repository_file" "flux" {

#   for_each  = local.flux_files_map
#   project   = gitlab_project.flux.id
#   file_path = each.value.repo_file_path
#   branch    = "main"
#   // content will be auto base64 encoded
#   content = base64encode(
#     templatefile("${path.module}/files/flux/${each.value.local_file_path}", {
#       customer        = var.customer
#       customer_domain = each.value.stage == "prod" ? "${local.customer_domain}" : "${each.value.stage}.${local.customer_domain}"
#       node_ip         = trimsuffix(local.environments_map[each.value.stage].network.ethernets.eth0.addresses[0], "/24")
#       repo_url        = "https://gitlab.smartify-it.io/${gitlab_project.flux.path_with_namespace}.git"
#       stage           = each.value.stage
#     })
#   )
#   author_email   = "terraform@example.com"
#   author_name    = "Terraform"
#   commit_message = "Add flux code"
# }

resource "github_repository_file" "this" {
  for_each  = local.flux_files_map
  repository          = github_repository.this.name
  branch              = "main"
  file                = each.value.repo_file_path
  content             =  templatefile("${path.module}/files/flux/${each.value.local_file_path}", {
    stage = each.value.stage
    repo_url = github_repository.this.http_clone_url
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}