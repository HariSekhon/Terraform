#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE  # 2021-01-18 17:50:43 +0000 (Mon, 18 Jan 2021) %]
#
#  [% URL %]
#
#  [% LICENSE %]
#
#  [% MESSAGE %]
#
#  [% LINKEDIN %]
#

# ============================================================================ #
#                      Selenoid Access from Jenkins on GKE
# ============================================================================ #

resource "google_compute_firewall" "selenoid-hub-gke" {
  name        = "selenoid-hub-gke-${basename(module.vpc.vpc_network)}"
  network = basename(module.vpc.vpc_network)
  description = "Selenoid Hub access from GKE VMs"

  allow {
    protocol = "tcp"
    ports    = ["4444"]
  }

  source_tags = ["goog-gke-node"]  # Jenkins run in GKE
  target_tags = ["selenoid-deployment"]  # label we've applied to marketplace vm
}

resource "google_compute_firewall" "selenoid-ui-vpn" {
  name        = "selenoid-ui-vpn"
  network     = "default"
  description = "Selenoid Hub access from VPN IPs"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = local.VPN_IPs
  target_tags   = ["selenoid-deployment"]
}
