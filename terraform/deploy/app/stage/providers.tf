terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.28"
    }
    # tfe = {
    #   source = "hashicorp/tfe"
    #   version = "0.36.0"
    # }
  }
}

provider "digitalocean" {
  # tokens are set in terraform cloud by setting the DIGITALOCEAN_TOKEN environment variable there
  token             = var.do_token
  spaces_access_id  = var.do_spaces_access_id
  spaces_secret_key = var.do_spaces_secret_key
}

provider "github" {
  # tokens are set in terraform cloud by setting the GITHUB_TOKEN environment variable there
  token = var.gh_token
}
