# Vitual Private Networks

__Objectives of this Lab__
- create vpn gateways in each network
- create vpn tunnels between the gateways
- verify vpn connectivity

## Task 1: Explore the networks and instances
- two vpc networks have been created in two separate regions
- both have firewall rules that allow icmp and ssh packets
- two virtual machine instances have been created `server-1` and `server-2`
    - both in two separate regions, with internal and external ip addresses

## Task 2: Create the VPN gateways and tunnels
__establish private communication between the two vm by creating vpn gateways and tunnels
between the two networks__

- reserve two static ip addresses named `vpn-1-static-ip` and `vpn-2-static-ip`
`gcloud compute addresses create vpn-1-static-ip --region=us-central1`
vpn-1-static-ip = 107.178.221.246
vpn-2-static-ip = 130.211.51.176

- create a vpn gateway `vpn-1` and tunnel `tunnel1to2` and vice versa for the other gateway

## Task 3: Verify VPN connectivity
