resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-east1"
  network       = google_compute_network.my-vpc.id
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.management-subnet.region
  network = google_compute_network.my-vpc.id
}

resource "google_compute_router_nat" "my-nat" {
  name                               = "my-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  #source_ip_ranges_to_nat            = "ALL_IP_RANGES"
  #source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}



# resource "google_compute_firewall" "instance-egress-allow" {
#   name    = "instance-egress-allow"
#   network = google_compute_network.my-vpc.name
#   priority = 500
#   direction = "EGRESS"
#   allow {
#     protocol = "all"
#   }
#   destination_ranges = ["0.0.0.0/0"]
#   target_tags = ["bastion"]
# }

