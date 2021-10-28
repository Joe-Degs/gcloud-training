# the terraform {} contains terraform settings like providers used to provision
# the service
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "3.5.0"
        }
    }
}

# the provider block contains provider specific configuration. In this case gcp
# will be used to provision resources
provider "google" {
    credentials = file(var.credentials_file)
    
    project = var.project
    region = var.region.us
    zone = var.zone.us
}

# resource block specify configuration for specific resources of the cloud
# provider. Some of these are networks, compute, identity managment, firewalls
# etc. For documentation on the resource names, types and supported arguments
# visit the resource provider's registry documentation on terraform registry
resouce "google_compute_network" "vpc_network" {
    name = "terraform_testnet"
    auto_create_subnetworks = true
}

# create firewall to allow for ping,ssh,http(s) to work
resource "google_compute_firewall" "default" {
    name = "fw-allow-ssh-http(s)"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports = ["80", "443", "22"]
    }
}

# create a vm instance
resource "google_compute_instance" "vm_instance" {
    name = "tr_instance"
    machine_type = "f1-micro"
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = google_compute_network.vpc_network.name

        access_config {

        }
    }
}
