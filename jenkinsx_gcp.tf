module "jx" {
  source = "jenkins-x/jx/google"

  gcp_project = "<my-gcp-project-id>"
}

output "jx_requirements" {
  value = module.jx.jx_requirements
}
