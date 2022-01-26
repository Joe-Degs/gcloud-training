# Useful Google Console Shell Commands
- To switch projects
```console
gcloud config set project <project-id>
```

- create vpc network
```console
gcloud compute networks create privatenet --subnet-mode=custom
```

- create subnet
```console
gcloud compute networks subnets create privatesubnet-us \
    --network=privatenet \
    --region=us-central1 \
    --range=172.16.0.0/24
```

- create firewall rule
``` conosole
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp \
    --direction=INGRESS \
    --priority=1000 \
    --network=privatenet \
    --action=ALLOW \
    --rules=icmp,tcp:22,tcp:3389 \
    --source-ranges=0.0.0.0/0
```

- create a vm instance
```console
gcloud compute instances create privatenet-us-vm \
    --zone=us-central1-c \
    --machine-type=f1-micro \
    --subnet=privatesubnet-us \
    --image-family=debian-10 \
    --image-project=debian-cloud \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard \
    --boot-disk-device-name=privatenet-us-vm
```

- create bucket
```
gsutil mb gs://<bucket-name>
```

- set compute zone
```console
gcloud config set compute/zone <zone-name>
```

- create iam service account
```console
gcloud iam service-accounts create test-service-account2 \
    --display-name "test-service-account2"
```

- grant role to service account
```console
gcloud projects add-iam-policy-binding <project-id> \
    --member serviceAccount:test-service-account2@<project-id>.iam.gserviceaccount.com \
    --role <role-name>
```

- get access control list for cloud storage bucket
```console
gsutil acl get gs://<bucket-name>/cat.jpg  > acl.txt
```

- set access control list
```console
gsutil acl set private gs://<bucket-name>/cat.jpg
```

- list current configs
```console
gcloud config list
```

- authenticate cloud service with service account
```console
gcloud auth activate-service-account --key-file credentials.json
```



## Areas of Special Attention
- StackDriver
- Kubernetes Engine
- Network Design
- Storage
- Access Management
