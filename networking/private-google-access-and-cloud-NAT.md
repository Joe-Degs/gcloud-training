# Implementing Private Google Access and Cloud NAT
things i'll do in this lab
- configure vm instance without external ip
- connect vm using identity aware proxy
- enable private google access on a subnet
- configure cloud NAT gateway
- verify access to public IP addresses of Google APIs and other connections to the internet

## Task 1: Create VPC network and firewall rules

[vpc network]
name=privatenet
subnet-creation-mode=custom
subnet-name=privatenet-us
region=us-central1
ip-address-range=10.130.0.0/20
- do not enable private google access

[firewall rule]
name=privatenet-allow-ssh
network=privatenet
targets=all instances in the network
source-filter=ip ranges
source-ip-ranges=35.235.240.0/20
protocols-and-ports=specified protocols and ports
- enable tcp port 22

*In order to connect to your private instance using SSH, you need to open an appropriate port on the firewall. IAP connections come from a specific set of IP addresses (35.235.240.0/20). Therefore, you can limit the rule to this CIDR range.*

[vm instance]
name=vm-internal
region=us-central1
zone=us-central1-c
series=n1
machine-type=n1-standard-1
bootdisk=debian 10

network=privatenet
subnetwork=privatenet-us
external-ip=none

*The default setting for a VM instance is to have an ephemeral external IP address. This behavior can be changed with a policy constraint at the organization or project level. To learn more about controlling external IP addresses on VM instances, refer to the external IP address documentation.*

### ssh to vm-internal to test IAP

- run command
gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

- ping google.com


## Task 2: Enable Private Google Access

### cloud storage bucket
name=bucket-andjoe
location-type=multi-region

### copy image to bucket
gsutil cp gs://cloud-training/gcpnet/private/access.svg gs://bucket-andjoe

### access image from vm instance
gsutil cp gs://bucket-andjoe/\*.svg .

- connect to vm-internal
gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

- copy image to vm-internal
gsutil cp gs://bucket-andjoe/\*.svg .

- ctrl+c

### enable private google access
- edit 'privatenet' and turn 'private google access' on

- try copying image to vm-internal again

- exit

## Task 3: Configure Cloud NAT

- update cloud shell
sudo apt-get update

- connect to vm-internal
gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

- update vm-internal
- ctrl+c

### Configure a Cloud NAT gateway

- Find network servies -> cloud nat
[nat config]
gateway-name=nat-config
vpc-network=privatenet
region=us-central1

- create new router
[router config]
name=nat-router

*The NAT mapping section allows you to choose the subnets to map to the NAT gateway. You can also manually assign static IP addresses that should be used when performing NAT. Do not change the NAT mapping configuration in this lab.*

### verify cloud nat gateway

- run update for vm-internal
- exit

*The Cloud NAT gateway implements outbound NAT, but not inbound NAT. In other words, hosts outside of your VPC network can only respond to connections initiated by your instances; they cannot initiate their own, new connections to your instances via NAT.*

## Task 4: Configure and view logs with Cloud NAT logging

- edit `nat-config`, click __advanced configurations__, under __stackdriver logging__, select __translation and errors__ and save

### nat logging in cloud operations

### generating logs

- ssh to vm-internal
gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

- re-synchronize package index for vm-internal (do sudo apt-get udpate)

### viewing logs
