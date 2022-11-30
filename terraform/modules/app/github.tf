## Secrets
resource "github_repository_environment" "env" {
  repository  = var.gh_repo_name # github_repository.repository.name
  environment = var.env
}

resource "github_actions_environment_secret" "droplet_host" {
  repository      = var.gh_repo_name # github_repository.repository.name
  environment     = github_repository_environment.env.environment
  secret_name     = "droplet_host"
  plaintext_value = digitalocean_droplet.droplet.ipv4_address
}

resource "github_actions_environment_secret" "tfvars" {
  for_each        = var.env_file_map
  repository      = var.gh_repo_name
  environment     = github_repository_environment.env.environment
  secret_name     = each.key
  plaintext_value = fileexists(each.value) ? filebase64(each.value) : ""

  # env files are kept out of version control, so not all users will have them locally.
  # Therefore, the idea is that the first user (who has the env files locally) creates
  # this variable on terraform cloud, and this remains unchanged. In case the variable
  # actually needs a change, it can be done via
  # `terraform destroy --target github_actions_environment_secret.tfvars` followed by
  # `terraform apply`
  lifecycle {
    ignore_changes = [
      plaintext_value
    ]
  }
}
