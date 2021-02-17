module "jx" {
  source = "jenkins-x/jx/google"

  # XXX: Edit
  gcp_project = "<my-gcp-project-id>"
}

output "jx_requirements" {
  value = module.jx.jx_requirements
}
