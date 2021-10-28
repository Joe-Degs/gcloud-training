# Configuring an HTTP Load Balancer with Autoscaling
__Objectives of this Lab__
1. create a health check firewall rule
2. create a NAT configuration using Cloud Router
3. create a custom image for a webserver
4. create an instance template based on the custom image
5. create two managed instance groups
6. configure http load balancer with ipv4 and v6
7. stress test the http load balancer

## Task 1: Configure a health check firewall rule
__Health checks determine which instances of a load balancer can receive new connections. For HTTP load balancing, the health check probes to your load-balanced instances come from addresses in the ranges 130.211.0.0/22 and 35.191.0.0/16. Your firewall rules must allow these connections.__

- create a firewall rule allowing packets on the loadbalancer's health check probe address range

## Task 2: Create a NAT configuration using Cloud Router
- create a default Cloud NAT in `us-central1` region with Cloud Router `nat-router-us-central1`


## Task 3

ipv4 = 34.117.186.136:80
ipv6 = [2600:1901:0:5872::]:80

