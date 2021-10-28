# Working with Virtual Machines

__Objectives__

- customize app server
- install and configure software
- configure network access
- schedule regular backups

## Task 1: Create the VM
- create a vm
- add a new ssd persistent disk for data storage
- add network

## Task 2: Prepare the data disk
- create directory as mount point and format the disk
`sudo mkdir -p /home/minecraft`
`sudo mkfs.ext4 -F -E lazy_itable_init=0,\
lazy_journal_init=0,discard \
/dev/disk/by-id/google-minecraft-disk`

- mount disk at the location
`sudo mount -o discard,defaults /dev/disk/by-id/google-minecraft-disk /home/minecraft`

## Task 3: Install and run the Application
- update package index and install java runtime environment
- install `screen` to run app in detached mode

## Task 4: Allow Client traffic
- create firewall rule to allow app communicate on tcp 25565
- verify app server availability

## Task 5: Schedule regualar backup
- create cloud storage bucket and store the name in the env var `YOUR_BUCKET_NAME`

## Task 6: Server maintenance
