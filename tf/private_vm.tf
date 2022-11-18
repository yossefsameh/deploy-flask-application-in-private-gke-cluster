resource "google_compute_instance" "my-vm" {
  name         = "my-vm"
  machine_type = "n1-standard-1"
  zone         = "asia-east1-b"
  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
 network_interface {
    network = google_compute_network.my-vpc.id
    subnetwork = google_compute_subnetwork.management-subnet.id
   
  }
  service_account {
    email  = google_service_account.myvmsa.email
    scopes = ["cloud-platform"]
  }
}