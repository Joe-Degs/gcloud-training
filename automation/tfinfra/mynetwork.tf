# create a network resource
resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks = "true"
}

# create firewall resource
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
  name    = "mynetwork-allow-http-ssh-rdp-icmp"
  network = google_compute_network.mynetwork.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }

  allow {
    protocol = "icmp"
  }
}

# create the mynet-us-vm instance
module "mynet-us-vm" {
  source           = "./instance"
  instance_name    = "mynet-us-vm"
  instance_zone    = "us-central1-a"
  instance_network = google_compute.mynetwork.self_link
}

# create the mynet-eu-vm instance
module "mynet-eu-vm" {
  source           = "./instance"
  instance_name    = "mynet-eu-vm"
  instance_zone    = "europe-west1-d"
  instance_network = google_compute.mynetwork.self_link
}
