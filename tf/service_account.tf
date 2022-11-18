resource "google_service_account" "myvmsa" {
  account_id   = "myvmsa"
  display_name = "myvmsa"
}

resource "google_project_iam_binding" "vm-role11" {
    role = "roles/container.admin"
    project     = "youssefs-project-367822"

    members = [
      "serviceAccount:${google_service_account.myvmsa.email}",


    ]
  
}

resource "google_project_iam_binding" "vm-role22" {
    role = "roles/storage.admin"
    project     = "youssefs-project-367822"

    members = [
      "serviceAccount:${google_service_account.myvmsa.email}",


    ]
  
}

resource "google_service_account" "clustersa" {
  account_id   = "clustersa"
  display_name = "clustersa"
}

resource "google_project_iam_binding" "cluster-role11" {
    role = "roles/storage.admin"
    project     = "youssefs-project-367822"

    members = [
      "serviceAccount:${google_service_account.clustersa.email}",

    ]
  
}

resource "google_project_iam_binding" "cluster-role22" {
    role = "roles/container.admin"
    project     = "youssefs-project-367822"

    members = [
      "serviceAccount:${google_service_account.clustersa.email}",
    ]
  
}