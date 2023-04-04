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
#                            G C P   F i r e w a l l
# ============================================================================ #

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

# Easily apply these standard rules uniformly to multiple VPC networks by simply calling this module with the 'network' parameter
#
# For rules specific to a single network, instead put them in the top level firewall.tf

# don't Terraform modify GKE auto-created firewall rules:
#
#   https://cloud.google.com/kubernetes-engine/docs/concepts/firewall-rules


# ============================================================================ #
#                       N e t w o r k   A d d r e s s e s
# ============================================================================ #

# Network addresses used in multiple places in different rules - set once here

locals {
  VPN_external_IPs = [
    #"x.x.x.x/32",
  ]

  VPN_internal_IPs = [
    #"10.x.0.0/16"
  ]

  london_office_IPs = [
    #"x.x.x.x/29",
  ]

  home_office_IPs = [
    #"x.x.x.x/29",
  ]

}


# ============================================================================ #
#             L o a d   B a l a n c e r   H e a l t h   C h e c k s
# ============================================================================ #

# https://cloud.google.com/load-balancing/docs/health-checks

resource "google_compute_firewall" "load-balancer-health-checks" {
  name        = "load-balancer-health-checks-${var.network}"
  network     = var.network
  description = "Load Balancer health checks source addresses"

  allow {
    protocol = "tcp"
    # might not be just HTTP(S), if you're sure it is then you can enable this line
    #ports    = ["80", "443"]
  }

  source_ranges = [
    # Load Balancer addresses - HTTP(S) / SSL Proxy / Internal TCP/UDP/HTTP(S)
    "35.191.0.0/16",
    "130.211.0.0/22",
    # Network Load Balancer addresses
    #"35.191.0.0/16", # in both lists
    "209.85.152.0/22",
    "209.85.204.0/22"
  ]
}


# ============================================================================ #
#                                    H T T P
# ============================================================================ #

# Cloudflare Proxied IP ranges (only these are seen when running DNS records in fully Proxied mode)
#                               client IPs become masked to these, use X-Forwarded-For in app, and
#                               restrict Cloudflare Firewall for Dev/Staging environments to only VPN / Office / 3rd party webhook addresses
#                               since otherwise all clients will go through your firewall and ingress as one of the below addresses
resource "google_compute_firewall" "http-cloudflare" {
  name        = "http-cloudflare-${var.network}"
  network     = var.network
  description = "HTTP(s) access from Cloudflare Proxied IP ranges"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # https://www.cloudflare.com/en-gb/ips/
  source_ranges = [
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "104.16.0.0/12",
    "108.162.192.0/18",
    "131.0.72.0/22",
    "141.101.64.0/18",
    "162.158.0.0/15",
    "172.64.0.0/13",
    "173.245.48.0/20",
    "188.114.96.0/20",
    "190.93.240.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17"
  ]
  target_tags = [
    "http-server",
    "https-server"
  ]
}


resource "google_compute_firewall" "http-office" {
  name        = "http-office-${var.network}"
  network     = var.network
  description = "HTTP(s) access from Office IPs"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = local.london_office_IPs
  target_tags = [
    "http-server",
    "https-server"
  ]
}


resource "google_compute_firewall" "http-VPN" {
  name        = "http-VPN-${var.network}"
  network     = var.network
  description = "HTTP(s) access from VPN public IPs"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = local.VPN_external_IPs
  target_tags = [
    "http-server",
    "https-server"
  ]
}


# vulernability scanner
resource "google_compute_firewall" "http-rapid7" {
  name        = "http-rapid7-${var.network}"
  network     = var.network
  description = "HTTP(s) access from Rapid7 IP ranges"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = [
    "35.158.144.37",
    "35.156.166.245",
    "172.104.153.232"
  ]
  target_tags = [
    "http-server",
    "https-server"
  ]
}


resource "google_compute_firewall" "http-webtrends" {
  name        = "http-webtrends-${var.network}"
  network     = var.network
  description = "HTTP(s) access from Webtrends IP"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = [
    "62.31.105.234",
    "213.123.137.249"
  ]
  target_tags = [
    "http-server",
    "https-server"
  ]
}

# ============================================================================ #
#                                     G K E
# ============================================================================ #

# XXX: move this to a GKE module where the var.master_range can be more easily populated

resource "google_compute_firewall" "gke-masters-to-nginx-ingress-validating-webhook" {
  name          = "gke-masters-to-nginx-ingress-validating-webhook"
  description   = "GKE masters to NGinx ingress validating webhook"
  project       = var.project
  network       = var.network
  source_ranges = [var.master_range]

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }
}

resource "google_compute_firewall" "gke-masters-to-cert-manager" {
  name          = "gke-masters-to-cert-manager"
  description   = "GKE masters to Cert Manager pods"
  project       = var.project
  network       = var.network
  source_ranges = [var.master_range]

  allow {
    protocol = "tcp"
    ports    = ["10250"]
  }
}

resource "google_compute_firewall" "gke-masters-to-kubeseal" {
  name          = "gke-masters-to-kubeseal"
  description   = "GKE masters to Sealed Secrets Controller for kubeseal"
  project       = var.project
  network       = var.network
  source_ranges = [var.master_range]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

# ============================================================================ #
#                                     S S H
# ============================================================================ #

resource "google_compute_firewall" "ssh-VPN" {
  name        = "ssh-VPN-${var.network}"
  network     = var.network
  description = "SSH access from VPN external IPs"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = local.VPN_external_IPs
}


resource "google_compute_firewall" "ssh-VPN-internal" {
  name        = "ssh-VPN-internal-${var.network}"
  network     = var.network
  description = "SSH access from VPN internal IPs"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = local.VPN_internal_IPs
}


resource "google_compute_firewall" "ssh-home-office" {
  name        = "ssh-home-office-${var.network}"
  network     = var.network
  description = "SSH access from Home office"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = local.home_office_IPs
}


# ============================================================================ #
#                                    I C M P
# ============================================================================ #

resource "google_compute_firewall" "icmp-VPN" {
  name        = "icmp-VPN-${var.network}"
  network     = var.network
  description = "ICMP access from VPN public IPs"

  allow {
    protocol = "icmp"
  }

  source_ranges = local.VPN_external_IPs
}


resource "google_compute_firewall" "icmp-VPN-internal" {
  name        = "icmp-VPN-internal-${var.network}"
  network     = var.network
  description = "ICMP access from VPN internal IPs"

  allow {
    protocol = "icmp"
  }

  source_ranges = local.VPN_internal_IPs
}


resource "google_compute_firewall" "icmp-home-office" {
  name        = "icmp-home-office-${var.network}"
  network     = var.network
  description = "ICMP access from Home office"

  allow {
    protocol = "icmp"
  }

  source_ranges = local.home_office_IPs
}


# ============================================================================ #
#          G C P   I A P   -   I d e n t i t y   A w a r e   P r o x y
# ============================================================================ #
# GCP IAP - Identity Aware Proxy
#
#   https://cloud.google.com/iap/docs/using-tcp-forwarding
#
resource "google_compute_firewall" "iap" {
  name        = "iap-${var.network}"
  network     = var.network
  description = "allows 'gcloud compute ssh <instance>' without public IPs"

  allow {
    protocol = "tcp"
    ports    = ["22"]
    #ports    = ["22", "3389"]  # SSH + RDP
  }

  source_ranges = ["35.235.240.0/20"]
}
