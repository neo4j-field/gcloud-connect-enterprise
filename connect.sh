#!/bin/bash

#SET THESE TWO VARIABLES!  The ZONE must match your default zone configured with #gcloud config
USER=gerlt
ZONE=us-central1-b

# Default is latest python driver, but you can specify
PYTHON_DRIVER_VERSION=
#PYTHON_DRIVER_VERSION=\=\=4.3.9

SERVER=connect-gcp-ent-$USER
echo "Creating Instance in Google Cloud."
#create the instance on gcloud
gcloud compute instances create $SERVER --project=neo4j-support-team-aura --zone=$ZONE --machine-type=e2-small --network-interface=network-tier=PREMIUM,subnet=default --maintenance-policy=MIGRATE --service-account=65436755986-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=ubuntu,image=projects/ubuntu-os-pro-cloud/global/images/ubuntu-pro-2004-focal-v20220404,mode=rw,size=10,type=projects/neo4j-support-team-aura/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

echo "Instance Creation Command Executed."
echo " "

sleep 30
echo "SSH Into Instance."
gcloud compute ssh $SERRVER -- "exit;"
expect "\r"
expect "\r"

sleep 10

echo "Copy Python Script."
gcloud compute scp ./hello.py $SERVER:~/

echo "Install Python Driver."
gcloud compute ssh $SERVER -- "sudo apt update;sudo apt-get install python3-pip -y;pip3 install neo4j$PYTHON_DRIVER_VERSION;chmod 755 ~/hello.py;"

echo "Script Completed. SSH with gcloud compute ssh <SERVER>"
