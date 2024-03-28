#CRIANDO INSTANCIA DE NOME 'NUCLEUS-JUMPHOST-554' COM COFIG ESPECIFICA DE MICRO E MACHINE

gcloud compute instances create nucleus-jumphost-554 \
  --machine-type=e2-micro \
  --image-family=debian-10 \
  --image-project=debian-cloud

#CRIANDO SERVÇO KUBERNETES DE NOME 'NUCLEUS-CLUSTER' VIA COMMAND LINE

gcloud container clusters create nucleus-cluster \
  --zone=us-central1-c \
  --num-nodes=3


#EDITANDO ARQUIVO ESPECIFICO VIA NANO

nano app-hello.yaml
    ##salvando arquivo 
    CTRL+X -> y -> ENTER

#REALIZANDO DEPLOY PARA IMPLANTAR CLUSTER COM ARQUIVO YAML

kubectl apply -f hello-app-deployment.yaml

#################################################################################################


##Criar um Modelo de Instância:

gcloud compute instance-templates create nucleus-instance-template \
  --machine-type=e2-micro \
  --image-family=debian-10 \
  --image-project=debian-cloud \
  --metadata=startup-script-url=gs://YOUR_BUCKET_NAME/startup.sh
Substitua YOUR_BUCKET_NAME pelo nome do seu bucket no Google Cloud Storage onde o script de inicialização (startup.sh) está localizado.

##Criar um Pool de Destino:

gcloud compute target-pools create nucleus-target-pool \
  --region=us-central1 \
  --http-health-check=http-basic-check

##Criar um Grupo Gerenciado de Instâncias:

gcloud compute instance-groups managed create nucleus-instance-group \
  --base-instance-name=nucleus-instance \
  --size=2 \
  --template=nucleus-instance-template \
  --target-pool=nucleus-target-pool


##Criar uma Regra de Firewall:

gcloud compute firewall-rules create grant-tcp-rule-849 \
  --allow=tcp:80 \
  --description="Allow TCP traffic on port 80" \
  --direction=INGRESS \
  --target-tags=nucleus-instance


##Criar uma Verificação de Integridade:

gcloud compute http-health-checks create http-basic-check


##Criar um Serviço de Back-end:

gcloud compute backend-services create nucleus-backend-service \
  --protocol=HTTP \
  --http-health-checks=http-basic-check \
  --global


##Anexar o Grupo Gerenciado de Instâncias ao Serviço de Back-end:

gcloud compute backend-services add-backend nucleus-backend-service \
  --instance-group=nucleus-instance-group \
  --instance-group-region=us-central1 \
  --global


##Criar um Mapa de URL:

gcloud compute url-maps create nucleus-url-map \
  --default-service=nucleus-backend-service


##Criar uma Regra de Encaminhamento:

gcloud compute target-http-proxies create nucleus-http-proxy \
  --url-map=nucleus-url-map


##Criar um Balanceador de Carga HTTP:

gcloud compute forwarding-rules create nucleus-http-rule \
  --global \
  --target-http-proxy=nucleus-http-proxy \
  --port-range=80
