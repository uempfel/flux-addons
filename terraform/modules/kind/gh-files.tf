locals {
  flux_fileset = fileset("${path.module}/files/flux", "**")
  flux_files_helper = flatten([
    for stage, details in local.environments_map : [
      for file_path in local.flux_fileset : {
        local_file_path = file_path,
        repo_file_path  = "clusters/${stage}/${trimsuffix(file_path, ".tpl")}",
        config          = details
        stage           = stage
      }
    ]
  ])
  flux_files_map = { for entry in local.flux_files_helper : entry.repo_file_path => entry }
}

resource "github_repository_file" "this" {
  for_each   = local.flux_files_map
  repository = github_repository.this.name
  branch     = "main"
  file       = each.value.repo_file_path
  content = templatefile("${path.module}/files/flux/${each.value.local_file_path}", {
    config   = each.value.config
    stage    = each.value.stage
    repo_url = "ssh://git@github.com/${github_repository.this.full_name}"
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}
