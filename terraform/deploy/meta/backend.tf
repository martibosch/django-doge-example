terraform {
  cloud {
    organization = "exaf-epfl"
    workspaces {
      name = "django-doge-example-meta"
    }
  }
}
