//Definindo zona/região via clod shell

gcloud config set compute/region us-east4
gcloud config set compute/zone us-east4-c


//Criando cluster em DATAPROC, tipo E2 - e2 stard 2 via cloud shell, com nome de example cluster

gcloud dataproc clusters create example-cluster \
--region=us-east4 \
--zone=us-east4-c \
--master-machine-type=e2-standard-2 \
--worker-machine-type=e2-standard-2 \
--num-workers=2 \
--master-boot-disk-size=30GB \
--worker-boot-disk-size=30GB