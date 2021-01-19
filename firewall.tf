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
#                            G C P   F i r e w a l l
# ============================================================================ #

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

resource "google_compute_network" "default" {
  name = "default"
}

#resource "google_compute_firewall" "http" {
#  name    = "http"
#  # use self_link instead of name as it's a unique reference
#  network = google_compute_network.default.self_link
#  network = module.vpc.default.self_link
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80", "443"]
#  }
#
#  source_ranges = ["0.0.0.0/0"]
#}

# GCP IAP
resource "google_compute_firewall" "iap" {
  name    = "iap"
  network = google_compute_network.default.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}
