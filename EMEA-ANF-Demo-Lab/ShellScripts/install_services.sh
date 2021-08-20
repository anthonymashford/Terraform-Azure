#!/bin/sh
apt-get update                # Get the latest package updates
apt-get install nfs-common -y # Install NFS service
apt-get install samba -y      # Install Samba serviceterraform -v