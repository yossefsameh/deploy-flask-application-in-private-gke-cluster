resource "google_service_account" "myvmsa" {
  account_id   = "myvmsa"
  display_name = "myvmsa"
}

resource "google_project_iam_binding" "my-iam-binding-cluster" {
    role = "roles/container.admin"
    project     = "youssefs-project-367822"

    members = [
      "serviceAccount:myvmsa@youssefs-project-367822.iam.gserviceaccount.com",

    ]
  
}


resource "google_service_account" "clustersa" {
  account_id   = "clustersa"
  display_name = "clustersa"
}

resource "google_project_iam_binding" "my-iam-binding-vm" {
    role = "roles/storage.admin"
    project     = "youssefs-project-367822"

    members = [
      "serviceAccount:clustersa@youssefs-project-367822.iam.gserviceaccount.com",

    ]
  
}