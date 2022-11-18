resource "google_compute_network" "my-vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL" 
}

resource "google_compute_firewall" "allow-in-ssh" {
  name    = "allow-in-ssh"
  network = google_compute_network.my-vpc.name
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
  #source_ranges = ["35.235.240.0/20"]
  #source_tags = ["bastion"]
}

