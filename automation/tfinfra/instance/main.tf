variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
  default = "n1-standard-1"
}

resource "google_compute_instance" "vm_instance" {
  name = var.instance_name
  zone = var.instance_zone
  type = var.instance_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = var.instance_network

    access_config {
      # allocate a one-to-one NAT IP to the instance
    }
  }
}
