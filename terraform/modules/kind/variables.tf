variable "github_token" {
  description = "GitHub token"
  #sensitive   = true
  type = string
}

variable "github_org" {
  description = "GitHub organization"
  type        = string
  default     = "uempfel"
}

variable "github_repository" {
  description = "GitHub repository"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name for cluster and GitHub project"
  type        = string
}

variable "config" {

  type = object({
    clusters = list(object({
      addon_config = optional(object({
        enable_ingress_nginx = optional(bool, false)
        enable_metrics_server = optional(bool, false)
        enable_observability = optional(bool, false)
        enable_cert_manager = optional(bool, false)
      }), null)
      stage          = string
      name           = string
      node_image     = string
      wait_for_ready = bool
      kind_config = optional(object({
        kind       = string
        apiVersion = string
        #kubeadmConfigPatches = list(string)
        nodes = list(object({
          role                 = string
          kubeadmConfigPatches = list(string)
          extraPortMappings = list(object({
            containerPort = string
            hostPort      = string
            protocol      = string
          }))
        }))
      }))
    }))
  })
}
