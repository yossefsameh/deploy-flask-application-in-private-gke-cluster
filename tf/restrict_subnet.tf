resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "asia-east1"
  network       = google_compute_network.my-vpc.id
  private_ip_google_access = true
}



# resource "google_compute_firewall" "egress-deny" {
#   name    = "egress-deny"
#   network = google_compute_network.my-vpc.name
#   priority = 1000
#   direction = "EGRESS"
#   deny {
#     protocol = "all"
#   }
#   destination_ranges = ["0.0.0.0/0"]
# }
