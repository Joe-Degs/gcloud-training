# Setting Up Network and HTTP LoadBalancers

## creating network loadbalancer
- create vm instances
```console
gcloud compute instances create www1 \
    --image-family debian-9 \
    --image-project debian-cloud \
    --zone us-central1-a \
    --tags network-lb-tag \
    --metadata startup-script="#! /bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo service apache2 restart
      echo '<!doctype html><html><body><h1>www1<h1></body></html>'
      | tee /var/www/html/index.html"
```

- create firewall rule to allow external traffic to vms
```console
gcloud compute firewall-rules create <firewall-name> \
    --target-tags <list-of-tags> \
    --allow <"protocol:port"="tcp:80">
```

- list instances
```console
gcloud compute instances list
```

- create static ip address for loadbalancer
```console
gcloud compute addresses create <ip-name> \
    --region <compute-region>
```

- add legacy health check
```console
gcloud compute http-health-checks create basic-check
```

- add target pool in the same region as your instances
```console
gcloud compute target-pools create <pool-name> \
    --region <compute-region> \
    --http-health-check <health-check-name>
```

- add instances to the target pool
```console
gcloud compute target-pools add-instances <pool-name> \
    --instances <comma-separated-list-of-instances>
```

- add forwarding rule
```console
gcloud compute forwarding-rules create <rule-name>
    --region <compute-region>
    --ports <port-numbers>
    --address <name-of-static-addresses>
    -target-pool <name-of-target-pool>
```

- get external IP address of forwarding-rule used by loadbalancer
```console
gcloud compute forwarding-rules describe <rule-name> \
    --region <compute-region>
    --zone <compute-zone>
```

## create http loadbalancer
- create loadbalancer template
```console
gcloud compute instance-templates create lb-backend-template \
   --region=us-central1 \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --image-family=debian-9 \
   --image-project=debian-cloud \
   --metadata=startup-script='#! /bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'
```

- create managed instance group based on template
```console
gcloud compute instance-groups managed create <group-name> \
    --template <instance-template-name> \
    --size=<int>
    --zone <compute-zone>
```

- create firewall rule to allow ingress traffic from google health checking services
```console
gcloud compute firewall-rules create <rule-name> \
    --network=default \
    --action=allow \
    --direction=ingress \
    --source-ranges=130.211.0.0/22,35.191.0.0/16 \
    --target-tags=<name-of-tags>
    --rules=<protocol:port>
```

- set up global static external ip address allowing access to load balancer
```console
gcloud compute addresses create <static-ip-name> \
    --ip-version=IPV4 \
    --global
```

- get ip address that is reserved
```console
gcloud compute addresses describe <static-ip-name> \
    --format="get(address)" \
    --global
```

- create health check for load balancer
```console
gcloud compute health-checks create <health-check-name> \
    --port <port-number>
```

- create backend service
```console
gcloud compute backend-services create <name> \
    --protocol=<protocol-name> \
    --port-name=<protoco-port-name ex: "http"> \
    --health-checks=<health-check-name> \
    --global
```

- add instance group as backend to backend service
```console
gcloud compute backend-services add-backend <backend-name> \
    --instance-group=<instance-group-name> \
    --instance-group-zone=<zone-instance-was-created> \
    --global
```

- create url to map incoming requests to default backend service
```console
gcloud compute url-maps create <url-name> \
    --default-service <backend-name>
```

- create a target http proxy to route requests to url map
```console
gcloud compute target-http-proxies create <http-proxy-name> \
    --url-map <url-name>
```

- create global forwarding rule to route requests to proxy
```console
gcloud compute forwarding-rules create <rule-name> \
    -- address=<static-ip-name>
    --global \
    --target-http-proxy=<http-proxy-name> \
    --ports=<port-number>
```

### links
- [load balancers](https://cloud.google.com/load-balancing/docs/network)