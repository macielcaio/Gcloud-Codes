### Build a Secure Google Cloud Network ###

#DEFINE AS VARIAVEIS DE AMBIENTE PARA O GCLOUD QUE SERÃO UTILIZADAS NOS SCRIPTS
export IAP_NETWORK_TAG=allow-ssh-iap-ingress-ql-627
export INTERNAL_NETWORK_TAG=allow-ssh-internal-ingress-ql-627
export HTTP_NETWORK_TAG=allow-http-ingress-ql-627
export ZONE=europe-west1-c

#Check the firewall rules. Remove the overly permissive rules.

    gcloud compute firewall-rules delete ssh-ingress
    gcloud compute firewall-rules delete http-ingress
    gcloud compute firewall-rules delete internal-ssh-ingress

#Create a firewall rule that allows SSH (tcp/22) from the IAP service. The firewall rule must be enabled for the bastion host instance using a network tag of allow-ssh-iap-ingress-ql-627.

    gcloud compute firewall-rules create ssh-ingress --allow=tcp:22 --source-ranges=35.235.240.0/20 --target-tags=$IAP_NETWORK_TAG --network=acme-vpc --project=qwiklabs-gcp-01-91c6e9158171
    gcloud compute instances add-tags bastion --tags=$IAP_NETWORK_TAG --zone=$ZONE --project=qwiklabs-gcp-01-91c6e9158171


#Create a firewall rule that allows traffic on HTTP (tcp/80) to any address and add network tag on juice-shop

    gcloud compute firewall-rules create http-ingress --allow=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=$HTTP_NETWORK_TAG --network=acme-vpc --project=qwiklabs-gcp-01-91c6e9158171
    gcloud compute instances add-tags juice-shop --tags=$HTTP_NETWORK_TAG --zone=$ZONE --project=qwiklabs-gcp-01-91c6e9158171

#Create a firewall rule that allows traffic on SSH (tcp/22) from acme-mgmt-subnet

    gcloud compute firewall-rules create internal-ssh-ingress --allow=tcp:22 --source-ranges=192.168.10.0/24 --target-tags=$INTERNAL_NETWORK_TAG --network=acme-vpc --project=qwiklabs-gcp-01-91c6e9158171
    gcloud compute instances add-tags juice-shop --tags=$INTERNAL_NETWORK_TAG --zone=$ZONE --project=qwiklabs-gcp-01-91c6e9158171
