resource "google_container_cluster" "my-private-cluster" {
  name               = "my-private-cluster"
  location = "asia-east1-a"
  network = google_compute_network.my-vpc.id
  subnetwork               = google_compute_subnetwork.restricted-subnet.id
  remove_default_node_pool = true
  initial_node_count = 1
#   node_locations = [
#     "asia-east1-b"
#   ]

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
    cidr_block   = "10.0.0.0/24"
    display_name = "vm-private-cidr"
    }
  }
 ip_allocation_policy {
    cluster_ipv4_cidr_block  = "192.168.0.0/21"
    services_ipv4_cidr_block = "192.168.8.0/27" 
}
}

resource "google_container_node_pool" "my-pool" {
  name       = "my-pool"
  cluster    = google_container_cluster.my-private-cluster.id
  location   =  "asia-east1-a"
  node_count = 1
  max_pods_per_node = 30

 node_config {
    #preemptible  = false
    machine_type = "n1-standard-1"

    service_account = google_service_account.clustersa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}