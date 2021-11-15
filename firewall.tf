#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE  # 2021-01-18 17:50:43 +0000 (Mon, 18 Jan 2021) %]
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                                F i r e w a l l
# ============================================================================ #

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

# don't Terraform modify GKE auto-created firewall rules:
#
#   https://cloud.google.com/kubernetes-engine/docs/concepts/firewall-rules


# although this is in the docs I don't consider this good practice, something as simple as a typo in the description could force a replacement!
#resource "google_compute_network" "default" {
#  name = "default"
#  # needs to avoid replacement
#  description = "Default network for the project"
#}

# ============================================================================ #
#         Firewall rules applied to both default and custom vpc networks
# ============================================================================ #

# adjacent Firewall module contains many common firewall rules such as Cloudflare Proxied HTTP(s), SSH, ICMP, IAP

#module "firewall" {
#  source  "./firewall"
#  # needs string, not self_link so basename to get the network name as a string
#  network = basename(module.vpc.vpc_network)
#}
#
#module "firewall-default-network" {
#  source  = "./firewall"
#  network = "default"
#}


# ============================================================================ #
#                  Firewall Rules only applying to one network
# ============================================================================ #

#resource "google_compute_firewall" "http" {
#  name    = "http"
#
#  # avoid creating network just to reference self_link, name it explicitly instead
#  network = "default"
#
#  # use self_link instead of name as it's a unique reference
#  #network = google_compute_network.default.self_link
#
#  # if network is created by module (eg. 'vpc_network'), the module must specify an output value for us to reference ( 'output "vpc_network" { value = google_compute_network.vpc_network.self_link }' )
#  #network = module.vpc.vpc_network
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80", "443"]
#  }
#
#  source_ranges = ["0.0.0.0/0"]
#}
