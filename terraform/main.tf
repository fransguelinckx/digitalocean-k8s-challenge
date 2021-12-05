module "doks_flux_cd" {
  source = "github.com/digitalocean/container-blueprints/create-doks-with-terraform-flux"

  # DOKS 
  # DO API TOKEN (string value)
  do_api_token                 = "8d1e6d028ee0f464de3e1204823b449d575e52d885aefe6e3e7c34ff5842096b"
  doks_cluster_name            = "frans-k8s-cluster"          # Name of this `DOKS` cluster ? (string value)
  # What region should this `DOKS` cluster be provisioned in ? (string value)
  doks_cluster_region          = "ams3"
  doks_cluster_version         = "1.21.5-do.0"# What Kubernetes version should this `DOKS` cluster use ? (string value)
  doks_cluster_pool_size       = "s-1vcpu-2gb"     # What machine type to use for this `DOKS` cluster ? (string value)
  doks_cluster_pool_node_count = 3 # How many worker nodes this `DOKS` cluster should have ? (integer value)

  # GitHub
  # Important notes:
  #  - This module expects your Git `repository` and `branch` to be created beforehand
  #  - Currently, the `github_token` doesn't work with SSO
  github_user              = "fransguelinckx"               # Your `GitHub` username
  # Your `GitHub` personal access token
  github_token             = "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"
  # Git repository where `Flux CD` manifests should be stored
  git_repository_name      = "digitalocean-k8s-challenge"
  git_repository_branch    = "main"     # Branch name to use for this `Git` repository (e.g.: `main`)
  # Git repository path where the manifests to sync are committed (e.g.: `clusters/dev`)
  git_repository_sync_path = "fluxcd"
}