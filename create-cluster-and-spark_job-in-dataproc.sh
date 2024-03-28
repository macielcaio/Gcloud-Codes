#CRIA CLUSTER VIA DATAPROC NO COMMAND LINE GCLOUD SHELL

gcloud dataproc clusters create example-cluster 
--worker-boot-disk-size 500 --worker-machine-type=e2-standard-4 
--master-machine-type=e2-standard-4

#CRIA spark JOB PARA O CLUSTER NO DATAPROC

gcloud dataproc jobs submit spark --cluster example-cluster \
  --class org.apache.spark.examples.SparkPi \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000 

#ALTERA O NUMERO DE WORKS NO CLUSTER DO DATAPROC

  gcloud dataproc clusters update example-cluster --num-workers 4

#PODE USAR O MESMO COMANDO PARA DIMINUIR O NUMERO DE WORKERS NO CLUSTER

gcloud dataproc clusters update example-cluster --num-workers 2