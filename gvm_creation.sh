gcloud compute instances create mygcp1 mygcp2 mygcp3 \
           --zone=us-central1-a \
           --image-family=ubuntu-2204-lts \
           --image-project=ubuntu-os-cloud \
           --machine-type=e2-medium \
           --tags=openall \
           --boot-disk-size=20GB


