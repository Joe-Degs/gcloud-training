# VPC Networking Lab

## Task 2

### Create auto-mode network
name = mynetwork
europe-west1-ip = 10.132.0.0/20
us-central1-ip = 10.128.0.0/20

### Create VM instance in us-central1
name = mynet-us-vm
region = us-central1
zone = us-central1-c
series = N1
machine-type = n1-standard-1
boot-disk = debian 10

name = mynet-eu-region
region = europe-west1

### Create custom mode network
name = managementnet
subnet-name = mangementsubnet-us
region = us-central1
ip-address-range = 10.130.0.0/30
